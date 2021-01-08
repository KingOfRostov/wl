import { createRouter, createWebHistory } from 'vue-router'
import Home from '../views/Home.vue'
import axios from 'axios'

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

router.beforeEach((to, from, next) => {
    if (to.name !== 'login') {
        axios({
            method: 'post',
            url: 'session/check',
            data: {
                token: localStorage.getItem('token')
            }
        }).then((response) => {
            const status =
                JSON.parse(response.status);

            if (status == '200') {
                next();
            } else {
                next({ name: 'login' });
            }
        }).catch(() => {
            next({ name: 'login' });
        })
    } else {
        next();
    }
})

export default router