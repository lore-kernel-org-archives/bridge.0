Date: Tue, 10 Apr 2007 10:49:21 -0700
From: Stephen Hemminger <shemminger@linux-foundation.org>
Message-ID: <20070410104921.4b90a292@freekitty>
In-Reply-To: <C953BD512FDBF641B6AC6D59B46B55F002484DBA@WSMSG2154V.srv.dir.telstra.com>
References: <C953BD512FDBF641B6AC6D59B46B55F002484DBA@WSMSG2154V.srv.dir.telstra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] Bridge Problem: Ping works, nothing else does...
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "Bainbridge, David D" <David.D.Bainbridge@team.telstra.com>
Cc: bridge@lists.linux-foundation.org

On Tue, 10 Apr 2007 14:38:46 +1000
"Bainbridge, David D" <David.D.Bainbridge@team.telstra.com> wrote:

> Hi,
> I'm a newbie to linux to an extent but have a need to set up a linux
> bridge to do some paclet loss testing using netem.  I have a PC with two
> NIC cards and Fedora 6.  I have created the bridge using the following
> commands
> 
> #brctl addbr mybridge
> #brctl addif mybridge eth0
> #brctl addif mybridge eth1
> #brctl mybridge up
> 

I assume you setup IP address for mybridge:
  ifconfig mybridge 192.168.0.X

Check status with:
  brctl showstp mybridge


> Physically I have two IP devices with static IP addresses connected to
> the two NIC cards via cross over cables.  I have tested the NIC cards in
> a non bridged mode and they work fine as normal NICs.  In bridged mode I
> can ping the other IP device.  The IP devices are actually realtime
> audio over IP codec devices and they stream using RTP on UDP port 5000.
> If I connect the cross over cable directly between the two codec devices
> the audio is transferred fine, if I put the linux bridge between them I
> get nothing but I can still ping.....
> 
> A brctl showstp shows the eth0 and eth1 are in forwarding status but
> nothing is happenig.  Can anyone help.  Both Eth1 and 0 are set to Ip
> address of 0.0.0.0
> 
> Thanks
> 
> 
> Regards
> David Bainbridge

What hardware is being used for eth0 and eth1, I assume both are normal
ether devices. They need to support source address spoofing, and promiscuous
mode.


-- 
Stephen Hemminger <shemminger@linux-foundation.org>
