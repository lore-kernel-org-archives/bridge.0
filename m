Return-Path: <giometti@enneenne.com>
Date: Mon, 15 Oct 2012 18:39:40 +0200
From: Rodolfo Giometti <giometti@enneenne.com>
Sender: giometti@enneenne.com
Message-ID: <20121015163940.GG28101@enneenne.com>
References: <20121009142337.GO28136@enneenne.com>
	<201210091842.36717.vitas@nppfactor.kiev.ua>
	<20121009155800.GR28136@enneenne.com>
	<20121012093659.GB14293@enneenne.com>
	<20121015152449.GF28101@enneenne.com>
	<20121015154528.GD30620@enneenne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20121015154528.GD30620@enneenne.com>
Subject: Re: [Bridge] MSTPd in RSTP mode is sometimes slow...
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Vitalii Demianets <vitas@nppfactor.kiev.ua>
Cc: bridge@lists.linux-foundation.org

On Mon, Oct 15, 2012 at 05:45:28PM +0200, Rodolfo Giometti wrote:
> 
> The mstpd daemon needs ~0.7s to rerun the function! =:-/

I discovered why... I modified these funtions:

static inline void run_timeouts(void)
{
LOG("------> 0");
    bridge_one_second();
    ++(nexttimeout.tv_sec);
LOG("------> 10");
}

int epoll_main_loop(void)
{
    gettimeofday(&nexttimeout, NULL);
    ++(nexttimeout.tv_sec);
#define EV_SIZE 8
    struct epoll_event ev[EV_SIZE];

    while(1)
    {
        int r, i;
        int timeout;

        struct timeval tv;
LOG("------> 0");
        gettimeofday(&tv, NULL);
        timeout = time_diff(&nexttimeout, &tv);
        if(timeout < 0)
        {
            run_timeouts();
            timeout = 0;
        }

LOG("------> 1");
        r = epoll_wait(epoll_fd, ev, EV_SIZE, timeout);
        if(r < 0 && errno != EINTR)
        {
            fprintf(stderr, "epoll_wait: %m\n");
            return -1;
        }
LOG("------> 2");
        for(i = 0; i < r; ++i)
        {
            struct epoll_event_handler *p = ev[i].data.ptr;
            if(p != NULL)
                p->ref_ev = &ev[i];
        }
LOG("------> 3");
        for (i = 0; i < r; ++i)
        {
            struct epoll_event_handler *p = ev[i].data.ptr;
            if(p && p->handler)
                p->handler(ev[i].events, p);
        }
LOG("------> 4");
        for (i = 0; i < r; ++i)
        {
            struct epoll_event_handler *p = ev[i].data.ptr;
            if(p != NULL)
                p->ref_ev = NULL;
        }
LOG("------> 10");
    }

    return 0;
}

and I get:

1038909843.937476: bridge_bpdu_rcv: ifindex 6, len 60
1038909843.941673: MSTP_IN_rx_bpdu: br0:mrvl4 received RST BPDU
1038909843.946618: br_state_machines_run: ------> 0
1038909843.952425: br_state_machines_run: ------> 1
1038909843.957172: br_state_machines_run: ------> 2
1038909843.961917: br_state_machines_run: ------> 3
1038909843.966664: br_state_machines_run: ------> 4
1038909843.971420: br_state_machines_run: ------> 5
1038909843.976163: PISM_to_RECEIVE: br0:mrvl4:0 
1038909843.980921: PISM_to_SUPERIOR_DESIGNATED: br0:mrvl4:0 
1038909843.985399: PISM_to_CURRENT: br0:mrvl4:0 
1038909843.990954: br_state_machines_run: ------> 6
1038909843.995443: br_state_machines_run: ------> 7
1038909844.000183: br_state_machines_run: ------> 8
1038909844.004924: br_state_machines_run: ------> 9
1038909844.009673: br_state_machines_run: ------> 10
1038909844.014428: epoll_main_loop: ------> 4
1038909844.019259: epoll_main_loop: ------> 10
1038909844.023471: epoll_main_loop: ------> 0
1038909844.027772: epoll_main_loop: ------> 1
1038909844.050699: epoll_main_loop: ------> 2
1038909844.053582: epoll_main_loop: ------> 3
1038909844.054920: epoll_main_loop: ------> 4
1038909844.059130: epoll_main_loop: ------> 10
1038909844.063343: epoll_main_loop: ------> 0
1038909844.067644: run_timeouts: ------> 0
1038909844.071868: br_state_machines_run: ------> 0
1038909844.075796: br_state_machines_run: ------> 1
1038909844.080549: br_state_machines_run: ------> 2
1038909844.085295: br_state_machines_run: ------> 3
1038909844.090675: br_state_machines_run: ------> 4
1038909844.094796: br_state_machines_run: ------> 5
1038909844.099543: PISM_to_UPDATE: br0:mrvl4:0 
1038909844.104295: PISM_to_CURRENT: br0:mrvl4:0 
1038909844.108681: br_state_machines_run: ------> 6
1038909844.113167: br_state_machines_run: ------> 7
1038909844.117920: br_state_machines_run: ------> 8
1038909844.122659: br_state_machines_run: ------> 9
1038909844.127408: br_state_machines_run: ------> 10
1038909844.132162: run_timeouts: ------> 10
1038909844.136993: epoll_main_loop: ------> 1
1038909844.141032: epoll_main_loop: ------> 2
1038909844.145236: epoll_main_loop: ------> 3
1038909844.149447: epoll_main_loop: ------> 4
1038909844.153668: epoll_main_loop: ------> 10
1038909844.157870: epoll_main_loop: ------> 0
1038909844.162174: epoll_main_loop: ------> 1
1038909845.040037: epoll_main_loop: ------> 2
1038909845.042945: epoll_main_loop: ------> 3
1038909845.044283: epoll_main_loop: ------> 4
1038909845.048494: epoll_main_loop: ------> 10
1038909845.052714: epoll_main_loop: ------> 0
1038909845.057008: run_timeouts: ------> 0
1038909845.061226: br_state_machines_run: ------> 0
1038909845.065160: br_state_machines_run: ------> 1
1038909845.069910: br_state_machines_run: ------> 2
1038909845.074665: br_state_machines_run: ------> 3
1038909845.079407: br_state_machines_run: ------> 4
1038909845.084165: MSTP_OUT_tx_bpdu: br0:mrvl4 sending RST BPDU

As you can see the daemon changes its internal state only when
run_timeouts() is executed!

I suppose this is not right...

Ciao,

Rodolfo

-- 

GNU/Linux Solutions                  e-mail: giometti@enneenne.com
Linux Device Driver                          giometti@linux.it
Embedded Systems                     phone:  +39 349 2432127
UNIX programming                     skype:  rodolfo.giometti
Freelance ICT Italia - Consulente ICT Italia - www.consulenti-ict.it
