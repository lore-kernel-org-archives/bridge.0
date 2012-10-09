Return-Path: <giometti@enneenne.com>
Date: Tue, 9 Oct 2012 17:58:01 +0200
From: Rodolfo Giometti <giometti@enneenne.com>
Sender: giometti@enneenne.com
Message-ID: <20121009155800.GR28136@enneenne.com>
References: <20121009142337.GO28136@enneenne.com>
	<201210091842.36717.vitas@nppfactor.kiev.ua>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201210091842.36717.vitas@nppfactor.kiev.ua>
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

On Tue, Oct 09, 2012 at 06:42:36PM +0300, Vitalii Demianets wrote:
> Hello, Rodolfo!
> 
> Please, describe your setup: how many devices do you have and how exactly are 
> they connected? 

ASCII Art:

  +------------+
  | my machine |----+
  +------------+    |
    |             +------------+
    |             |            |
    |             +------------+
  +------------+    |
  |    root    |----+ <----[A]
  +------------+

The "Event" is: the ring is opened in [A]

> Also, please specify which events exactly are you measuring the time interval 
> between. As I understand, you are measuring the time interval between some 
> event X not shown in the logs end the event Y = "br0:mrvl4:0 entering 
> forwarding state". What is event X?

Since I receive the external BPDU related with the Event (see
"bridge_bpdu_rcv: ifindex 6, len 60") to the message
"MSTP_OUT_set_state: br0:mrvl4:0 entering forwarding".

> I guess you have three devices connected in the ring. If so, is the device 
> under examination NOT the root bridge before event X, or after event X or in 
> both cases?

My device is not the root bridge and it never becomes the root bridge
nor before and after the Event.

Ciao,

Rodolfo

-- 

GNU/Linux Solutions                  e-mail: giometti@enneenne.com
Linux Device Driver                          giometti@linux.it
Embedded Systems                     phone:  +39 349 2432127
UNIX programming                     skype:  rodolfo.giometti
Freelance ICT Italia - Consulente ICT Italia - www.consulenti-ict.it
