/**
 * Copyright (c) 2023, WSO2 LLC (http://www.wso2.com) All Rights Reserved.
 *
 * WSO2 LLC licenses this file to you under the Apache License,
 * Version 2.0 (the "License"); you may not use this file except
 * in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied. See the License for the
 * specific language governing permissions and limitations
 * under the License.
 */

import { useEffect, useState } from 'react';
import Head from 'next/head';
import PlusIcon from '@heroicons/react/24/solid/PlusIcon';
import { Box, Button, Container, Stack, SvgIcon, Typography } from '@mui/material';
import { OrdersTable } from 'src/components/orders/orders-table';
import { OrdersSearch } from 'src/components/orders/orders-search';
import OrderSelect from 'src/components/orders/orders-dropdown';
import { getCustomerOrderUrl, getOrderUrl, getOrdersQuery } from 'src/constants/Constants';
import { getAPI } from 'src/api/ApiHandler';
import SimpleDialog from 'src/components/orders/view-order';
import { useQuery } from '@apollo/client';

const Page = () => {
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState(null);
  const [data, setData] = useState([]);
  const [customer, setCustomer] = useState("");
  const [status, setStatus] = useState("");
  const [filter, setFilter] = useState(false);
  const [open, setOpen] = useState(false);
  const [id, setId] = useState('');
  const [order, setOrder] = useState('');

  const { l, e, d } = useQuery(getOrdersQuery);
  if (loading) return <p></p>;
  if (error) return <p>Error: {error.message}</p>;

  const fetchOrderData = async (orderId) => {
    try {
      const response = await getAPI(getOrderUrl + "/" + orderId);
      if (response.status !== 200) {
        setError(response.message);
      } else {
        setError(null);
        setOrder(response.data);
      }
    } catch (error) {
      setError(error);
    }
  };

  const handleClickOpen = async (id) => {
    setId(id);
    await fetchOrderData(id);
    setOpen(true);
  };

  const handleClose = () => {
    setOpen(false);
  };

  const fetchData = async () => {
    setLoading(true);
    try {
      const response = customer != '' && status != '' ? await getAPI(getCustomerOrderUrl(customer) + "?status=" + status) : null;
      if (response == null) {
        return -1;
      }
      if (response.status !== 200) {
        setError(response.message);
      } else {
        setError(null);
        const d = await response.data;
        setData(d);
        setLoading(false);
      }
    } catch (error) {
      setError(error.message);
      setLoading(false);
    }
};

  useEffect(() => {
    var a = fetchData();
    if (a == -1) {
      setData(d.orders);
    }
  }, [filter]);

  useEffect(() => {

  }, [data]);


  const onSearchButtonClick = (e) => {
    e.preventDefault();
    setFilter(!filter);
  }
  
  const onSearchChange = (e) => {
    setCustomer(e.target.value);
  }

  const onStatusChange = (e) => {
    setStatus(e.target.value);
  }

  return (
    loading ? <div>Loading...</div> : error != null ? <div>{error}</div> :
    <>
      <Head>
        <title>
          Orders | MegaPort Kit
        </title>
      </Head>
      <Box
        component="main"
        sx={{
          flexGrow: 1,
          py: 8
        }}
      >
        <Container maxWidth="xl">
          <Stack spacing={3}>
            <Stack
              direction="row"
              justifyContent="space-between"
              spacing={4}
            >
              <Stack spacing={1}>
                <Typography variant="h4">
                  Orders
                </Typography>
              </Stack>
            </Stack>
            <Stack
              direction="row"
              alignContent={'center'}
              >
                <Box
                sx={{
                  display:"flex",
                  jusfifyContent:"center",
                  gap:"1rem"
                }}>
            <OrdersSearch 
              onChange={onSearchChange} 
              customer={customer}
            />
            <OrderSelect
              handleChange={onStatusChange}
              status={status}
            />
                </Box>
            <Button label="Search" value="Search" onClick={onSearchButtonClick}> Search </Button>
            </Stack>
            <OrdersTable
              count={data.length}
              items={data}
              handleClick={handleClickOpen}
              open={open}
            />
          </Stack>
        </Container>
        <SimpleDialog
          open={open}
          onClose={handleClose}
          id={id}
          order={order}
      />
      </Box>
    </>
  );
};


export default Page;
