import { createRouter, createWebHistory } from 'vue-router'
import ShowUser from '../views/ShowUser.vue'
import axios from 'axios'

const routes = [{
        path: '/:username',
        name: 'showUser',
        meta: { layout: 'main' },
        component: ShowUser,
        props: (route) => ({ username: route.params.username })
    },
    {
        path: '/login',
        name: 'login',
        meta: { layout: 'empty' },
        component: () =>
            import ('@/views/Login.vue')
    },
    {
        path: '/users',
        name: 'users',
        meta: { layout: 'main' },
        component: () =>
            import ('@/views/Users.vue')
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