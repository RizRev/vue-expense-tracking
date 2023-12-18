<template>
  <Header/>
  <div class="container">
    <Balance :total="+total"/>
    <IncomeExpenses :income="+income" :expense="+expense"/>
    <TransactionList :transactions="transactions" @transactionDeleted="handleTransactionDeleted"/>
    <AddTransaction @transactionSubmitted="handleTransactionSubmitted"/>
  </div>
</template>

<script setup>
  import Header from './components/Header.vue';
  import Balance from './components/Balance.vue';
  import IncomeExpenses from './components/IncomeExpense.vue';
  import TransactionList from './components/TransactionList.vue';
  import AddTransaction from './components/AddTransaction.vue';

  import { computed, ref, onMounted } from  'vue'

  import { useToast } from 'vue-toastification'

  onMounted(() => {
    const savedTransactions = JSON.parse(localStorage.getItem('transactions'));

    if (savedTransactions) {
      transactions.value = savedTransactions;
    }
  })

  const toast = useToast()

  const transactions = ref([])

  const total = computed(() => {
    return transactions.value.reduce((acc, transaction) => {
      return acc + transaction.amount;
    }, 0)
  })

  const income = computed(() => {
    return transactions.value
    .filter((transaction) => transaction.amount > 0)
    .reduce((acc, transaction) => {
      return acc + transaction.amount;
    }, 0)
    .toFixed(2)
  })

  const expense = computed(() => {
    return transactions.value
    .filter((transaction) => transaction.amount < 0)
    .reduce((acc, transaction) => {
      return acc + transaction.amount;
    }, 0)
    .toFixed(2)
  })

  const handleTransactionSubmitted = (transactionData) => {
    // console.log('ini di vue',transactionData)
    transactions.value.push({
      id:  generateUniqueId(),
      text: transactionData.text,
      amount: transactionData.amount
    })

    saveTransactionToLocalStorage()

    toast.success('add transaction successfully')
  }

  const generateUniqueId = () => {
    return Math.floor(Math.random() * 1000000)
  }

  const handleTransactionDeleted = (id) => {
    // console.log(id)
    transactions.value = transactions.value.filter(
      (transaction) => transaction.id !== id
    )

    toast.success('transactions deleted')
  }

  const saveTransactionToLocalStorage = () => {
    localStorage.setItem('transactions', JSON.stringify(transactions.value))
  }
  // export default {
  //   components: {
  //     Header, 
  //     Balance,
  //     IncomeExpenses,
  //     TransactionList,
  //     AddTransaction
  //   }
  // }
</script>