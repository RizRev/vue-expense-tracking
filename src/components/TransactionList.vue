<template>
    <h3>History</h3>
  <ul id="list" class="list">
    <li v-for="transaction in transactions" :key="transaction.id" :class="transaction.amount < 0 ? 'minus' : 'plus'">
        {{ transaction.text }} <span>${{ transaction.amount }}</span
      ><button @click="deleteTransaction(transaction.id)" class="delete-btn">
        x
      </button>
    </li>
    <!-- <li class="minus">
      
    </li>
    <li class="plus">
      Salary <span>$400</span
      ><button class="delete-btn">
        x
      </button>
    </li> -->
  </ul>
</template>

<script setup>
 import { defineProps } from 'vue';

 const emit = defineEmits(['transactionDeleted']);

 const props = defineProps({
  transactions: {
    type: Array,
    required: true
  }
 })

 const deleteTransaction = (id) => {
  emit('transactionDeleted', id);
 }

</script>
<!-- <script>
    export default {
        setup () {
            const transactions = [
                    {id: 1, text: "Salary", amount:1000},
                    {id: 2, text: "Flower", amount:-20},
                    {id: 3, text: "Steak", amount:-10}
                ]
            return {
                transactions
            }
        }
        // data() {
            
        // }
    }
</script> -->