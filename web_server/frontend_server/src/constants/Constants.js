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
import gql from 'graphql-tag';

export const resetServer = "http://localhost:9090";
export const graphQlServer = "http://localhost:9091";
export const wsServer = "http://localhost:9092";

// GET HTTP REST requests
export const getCustomerOrderUrl = (id) => resetServer + `/sales/customers/${id}/orders`;

// GET GraphQL Quries

export const graphQlUrl = graphQlServer + "/sales";

export const getOrdersQuery = 
    gql `query {
            orders {
                id
                ship { shipId }
                date
                status
                quantity
                item { itemId }
            }
        }`;
