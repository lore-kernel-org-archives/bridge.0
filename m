Date: Tue, 5 Oct 2010 11:54:58 +0200
From: Rodolfo Giometti <giometti@enneenne.com>
Sender: giometti@enneenne.com
Message-ID: <20101005095458.GB2584@enneenne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Bridge] Invalid BPDU transmission?
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

Hello,

in function STP_transmit_check_conditions (rstplib/transmit.c) the
case:

    case IDLE:
      if (!port->helloWhen) return STP_hop_2_state (this,
      TRANSMIT_PERIODIC);
      if (!port->sendRSTP && port->newInfo &&
          (port->txCount < TxHoldCount) &&
          (port->role == DesignatedPort) &&
          port->helloWhen)
        return STP_hop_2_state (this, TRANSMIT_CONFIG);
      if (!port->sendRSTP && port->newInfo &&
          (port->txCount < TxHoldCount) &&
          (port->role == RootPort) &&
          port->helloWhen)
        return STP_hop_2_state (this, TRANSMIT_TCN);
      if (port->sendRSTP && port->newInfo &&
          (port->txCount < TxHoldCount) &&
          ((port->role == RootPort) ||         <----
           (port->role == DesignatedPort)))
        return STP_hop_2_state (this, TRANSMIT_RSTP);
      break;

states that a RSTP bpdu can be transmitted even throught a RootPort
which, IMHO, is not correct... only topology change BPDU should be
sent over the RootPort. That's why I suggest to remove the line with
the arrow (<----).

Comments? :)

Ciao,

Rodolfo

-- 

GNU/Linux Solutions                  e-mail: giometti@enneenne.com
Linux Device Driver                          giometti@linux.it
Embedded Systems                     phone:  +39 349 2432127
UNIX programming                     skype:  rodolfo.giometti
Freelance ICT Italia - Consulente ICT Italia - www.consulenti-ict.it
