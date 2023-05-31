import React from 'react'
import ReactDOM from 'react-dom/client'
import App from './App.tsx'
import { ChakraProvider } from '@chakra-ui/react'
import { QueryClient, QueryClientProvider } from 'react-query'
import UserAuthProvider from './context/UserAuthProvider.tsx'

const queryClient = new QueryClient();

ReactDOM.createRoot(document.getElementById('root') as HTMLElement).render(
  <React.StrictMode>
    <QueryClientProvider client={queryClient}>
      <ChakraProvider>
        <UserAuthProvider>
          <App />
        </UserAuthProvider>
    </ChakraProvider>
    </QueryClientProvider>
  </React.StrictMode>,
)
