Return-Path: <giometti@enneenne.com>
Date: Mon, 15 Oct 2012 17:45:28 +0200
From: Rodolfo Giometti <giometti@enneenne.com>
Sender: giometti@enneenne.com
Message-ID: <20121015154528.GD30620@enneenne.com>
References: <20121009142337.GO28136@enneenne.com>
	<201210091842.36717.vitas@nppfactor.kiev.ua>
	<20121009155800.GR28136@enneenne.com>
	<20121012093659.GB14293@enneenne.com>
	<20121015152449.GF28101@enneenne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20121015152449.GF28101@enneenne.com>
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

On Mon, Oct 15, 2012 at 05:24:49PM +0200, Rodolfo Giometti wrote:
> On Fri, Oct 12, 2012 at 11:37:00AM +0200, Rodolfo Giometti wrote:
> 
> Looking better my tests here:
> 
> > 1038910509.489145: PISM_to_CURRENT: br0:mrvl4:0 
> > 1038910510.479677: MSTP_OUT_tx_bpdu: br0:mrvl4 sending RST BPDU
> 
> I noticed that we need ~1s from PISM_to_CURRENT to send out the BPDU!
> 
> How is it possible? =:-o

Let's take a look at this new test.

I modified the br_state_machines_run function as follow:

static void br_state_machines_run(bridge_t *br)
{
    port_t *prt;
    per_tree_port_t *ptp;
    tree_t *tree;

LOG("------> 0");

    if(!br->bridgeEnabled)
        return;

    /* 13.28  Port Receive state machine */
LOG("------> 1");
    FOREACH_PORT_IN_BRIDGE(prt, br)
        PRSM_run(prt);
    /* 13.29  Port Protocol Migration state machine */
LOG("------> 2");
    FOREACH_PORT_IN_BRIDGE(prt, br)
        PPMSM_run(prt);
    /* 13.30  Bridge Detection state machine */
LOG("------> 3");
    FOREACH_PORT_IN_BRIDGE(prt, br)
        BDSM_run(prt);
    /* 13.31  Port Transmit state machine */
LOG("------> 4");
    FOREACH_PORT_IN_BRIDGE(prt, br)
        PTSM_run(prt);

    /* 13.32  Port Information state machine */
LOG("------> 5");
    FOREACH_PORT_IN_BRIDGE(prt, br)
    {
        FOREACH_PTP_IN_PORT(ptp, prt)
            PISM_run(ptp);
    }

    /* 13.33  Port Role Selection state machine */
LOG("------> 6");
    FOREACH_TREE_IN_BRIDGE(tree, br)
        PRSSM_run(tree);

    /* 13.34  Port Role Transitions state machine */
LOG("------> 7");
    FOREACH_PORT_IN_BRIDGE(prt, br)
    {
        FOREACH_PTP_IN_PORT(ptp, prt)
            PRTSM_run(ptp);
    }
    /* 13.35  Port State Transition state machine */
LOG("------> 8");
    FOREACH_PORT_IN_BRIDGE(prt, br)
    {
        FOREACH_PTP_IN_PORT(ptp, prt)
            PSTSM_run(ptp);
    }
    /* 13.36  Topology Change state machine */
LOG("------> 9");
    FOREACH_PORT_IN_BRIDGE(prt, br)
    {
        FOREACH_PTP_IN_PORT(ptp, prt)
            TCSM_run(ptp);
    }

LOG("------> 10");
}

And rerun my test with the following outout:

1038910178.371891: bridge_bpdu_rcv: ifindex 6, len 60
1038910178.374841: MSTP_IN_rx_bpdu: br0:mrvl4 received RST BPDU
1038910178.376916: br_state_machines_run: ------> 0
1038910178.382722: br_state_machines_run: ------> 1
1038910178.387469: br_state_machines_run: ------> 2
1038910178.392215: br_state_machines_run: ------> 3
1038910178.396962: br_state_machines_run: ------> 4
1038910178.401717: br_state_machines_run: ------> 5
1038910178.406460: PISM_to_RECEIVE: br0:mrvl4:0 
1038910178.411217: PISM_to_SUPERIOR_DESIGNATED: br0:mrvl4:0 
1038910178.415696: PISM_to_CURRENT: br0:mrvl4:0 
1038910178.421251: br_state_machines_run: ------> 6
1038910178.425740: br_state_machines_run: ------> 7
1038910178.430479: br_state_machines_run: ------> 8
1038910178.435221: br_state_machines_run: ------> 9
1038910178.439971: br_state_machines_run: ------> 10
1038910178.660628: br_state_machines_run: ------> 0
1038910178.663528: br_state_machines_run: ------> 1
1038910178.665404: br_state_machines_run: ------> 2
1038910178.670153: br_state_machines_run: ------> 3
1038910178.674901: br_state_machines_run: ------> 4
1038910178.679651: br_state_machines_run: ------> 5
1038910178.684405: PISM_to_UPDATE: br0:mrvl4:0 
1038910178.689151: PISM_to_CURRENT: br0:mrvl4:0 
1038910178.693541: br_state_machines_run: ------> 6
1038910178.698018: br_state_machines_run: ------> 7
1038910178.702782: br_state_machines_run: ------> 8
1038910178.707516: br_state_machines_run: ------> 9
1038910178.712266: br_state_machines_run: ------> 10
1038910179.406118: bridge_bpdu_rcv: ifindex 7, len 60
1038910179.409005: MSTP_IN_rx_bpdu: br0:mrvl5 received RST BPDU
1038910179.411081: br_state_machines_run: ------> 0
1038910179.416878: br_state_machines_run: ------> 1
1038910179.421636: br_state_machines_run: ------> 2
1038910179.426377: br_state_machines_run: ------> 3
1038910179.431126: br_state_machines_run: ------> 4
1038910179.435881: MSTP_OUT_tx_bpdu: br0:mrvl4 sending RST BPDU
1038910179.448880: br_state_machines_run: ------> 5
1038910179.452019: PISM_to_RECEIVE: br0:mrvl5:0 
1038910179.453895: PISM_to_SUPERIOR_DESIGNATED: br0:mrvl5:0 
1038910179.458373: PISM_to_CURRENT: br0:mrvl5:0 
1038910179.463925: br_state_machines_run: ------> 6
1038910179.468415: br_state_machines_run: ------> 7
1038910179.473154: br_state_machines_run: ------> 8
1038910179.477896: br_state_machines_run: ------> 9
1038910179.482652: br_state_machines_run: ------> 10
1038910179.487435: bridge_bpdu_rcv: ifindex 6, len 60
1038910179.492237: MSTP_IN_rx_bpdu: br0:mrvl4 received RST BPDU
1038910179.497183: br_state_machines_run: ------> 0
1038910179.502991: br_state_machines_run: ------> 1
1038910179.507737: br_state_machines_run: ------> 2
1038910179.512483: br_state_machines_run: ------> 3
1038910179.517231: br_state_machines_run: ------> 4
1038910179.521986: br_state_machines_run: ------> 5
1038910179.526729: PISM_to_UPDATE: br0:mrvl4:0 
1038910179.531484: PISM_to_CURRENT: br0:mrvl4:0 
1038910179.535868: PISM_to_RECEIVE: br0:mrvl4:0 
1038910179.540788: PISM_to_NOT_DESIGNATED: br0:mrvl4:0 
1038910179.544830: PISM_to_CURRENT: br0:mrvl4:0 
1038910179.549936: br_state_machines_run: ------> 6
1038910179.554416: br_state_machines_run: ------> 7
1038910179.559174: br_state_machines_run: ------> 8
1038910179.563919: MSTP_OUT_set_state: br0:mrvl4:0 entering learning state

Look here:

1038910178.712266: br_state_machines_run: ------> 10
1038910179.406118: bridge_bpdu_rcv: ifindex 7, len 60
1038910179.409005: MSTP_IN_rx_bpdu: br0:mrvl5 received RST BPDU
1038910179.411081: br_state_machines_run: ------> 0

The mstpd daemon needs ~0.7s to rerun the function! =:-/

Ciao,

Rodolfo

-- 

GNU/Linux Solutions                  e-mail: giometti@enneenne.com
Linux Device Driver                          giometti@linux.it
Embedded Systems                     phone:  +39 349 2432127
UNIX programming                     skype:  rodolfo.giometti
Freelance ICT Italia - Consulente ICT Italia - www.consulenti-ict.it
