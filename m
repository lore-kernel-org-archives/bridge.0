Return-Path: <giometti@enneenne.com>
Date: Tue, 9 Oct 2012 16:23:37 +0200
From: Rodolfo Giometti <giometti@enneenne.com>
Sender: giometti@enneenne.com
Message-ID: <20121009142337.GO28136@enneenne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Bridge] MSTPd in RSTP mode is sometimes slow...
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

Hello,

I'm currently using the MSTPd daemon on a custom PowerPC based board
and I notice that when forced in RSTP mode a port trnasition to the
forwarding state, sometimes, needs about 1.2s and, sometimes, needs
about 80ms!

When the transition is quick I get the following log:

1038912050.392513: bridge_bpdu_rcv: ifindex 6, len 60
1038912050.397313: MSTP_IN_rx_bpdu: br0:mrvl4 received RST BPDU
1038912050.431810: PISM_to_UPDATE: br0:mrvl4:0 
1038912050.436557: PISM_to_CURRENT: br0:mrvl4:0 
1038912050.440949: PISM_to_RECEIVE: br0:mrvl4:0 
1038912050.445431: PISM_to_NOT_DESIGNATED: br0:mrvl4:0 
1038912050.449905: PISM_to_CURRENT: br0:mrvl4:0 
1038912050.468990: MSTP_OUT_set_state: br0:mrvl4:0 entering learning state
1038912050.476744: set_port_role: port mrvl4 role 3
1038912050.483704: MSTP_OUT_set_state: br0:mrvl4:0 entering forwarding state
1038912050.488299: set_port_role: port mrvl4 role 3
1038912050.506378: MSTP_OUT_flush_all_fids: br0:mrvl5:0 Flushing forwarding data base
1038912051.199682: MSTP_OUT_tx_bpdu: br0:mrvl4 sending RST BPDU


On the other hand when the transition is slow I get:

1038911701.406963: bridge_bpdu_rcv: ifindex 6, len 60
1038911701.411766: MSTP_IN_rx_bpdu: br0:mrvl4 received RST BPDU
1038911701.446256: PISM_to_RECEIVE: br0:mrvl4:0 
1038911701.451015: PISM_to_SUPERIOR_DESIGNATED: br0:mrvl4:0 
1038911701.455493: PISM_to_CURRENT: br0:mrvl4:0 
1038911702.021584: PISM_to_UPDATE: br0:mrvl4:0 
1038911702.026330: PISM_to_CURRENT: br0:mrvl4:0 
1038911702.204368: PISM_to_UPDATE: br0:mrvl4:0 
1038911702.209114: PISM_to_CURRENT: br0:mrvl4:0 
1038911703.199645: MSTP_OUT_tx_bpdu: br0:mrvl4 sending RST BPDU
1038911703.224464: MSTP_OUT_set_state: br0:mrvl4:0 entering learning state
1038911703.232292: set_port_role: port mrvl4 role 3
1038911703.245552: bridge_bpdu_rcv: ifindex 6, len 60
1038911703.250359: MSTP_IN_rx_bpdu: br0:mrvl4 received RST BPDU
1038911703.284849: PISM_to_RECEIVE: br0:mrvl4:0 
1038911703.289604: PISM_to_NOT_DESIGNATED: br0:mrvl4:0 
1038911703.294079: PISM_to_CURRENT: br0:mrvl4:0 
1038911703.313165: MSTP_OUT_set_state: br0:mrvl4:0 entering forwarding state

Note that my machine is NOT the root bridge and the connection is a
simple ring where I remove the connection between the other two
machines.

Any advice? :)

Ciao,

Rodolfo

-- 

GNU/Linux Solutions                  e-mail: giometti@enneenne.com
Linux Device Driver                          giometti@linux.it
Embedded Systems                     phone:  +39 349 2432127
UNIX programming                     skype:  rodolfo.giometti
Freelance ICT Italia - Consulente ICT Italia - www.consulenti-ict.it
