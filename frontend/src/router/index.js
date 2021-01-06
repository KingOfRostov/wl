import { createRouter, createWebHistory } from 'vue-router'
import Home from '../views/Home.vue'

const routes = [{
        path: '/',
        name: 'home',
        meta: { layout: 'main' },
        component: Home
    },
    {
        path: '/login',
        name: 'login',
        meta: { layout: 'empty' },
        component: () =>
            import ('@/views/Login.vue')
    }
]

const router = createRouter({
    history: createWebHistory(process.env.BASE_URL),
    routes
})

export default router