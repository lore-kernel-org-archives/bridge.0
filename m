From: Bart De Schuymer <bdschuym@pandora.be>
Date: Mon, 24 May 2004 21:02:12 +0200
References: <E1BRpWg-0004Aq-D0@www3.emo.freenet-rz.de>
In-Reply-To: <E1BRpWg-0004Aq-D0@www3.emo.freenet-rz.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200405242102.12842.bdschuym@pandora.be>
Subject: [Bridge] Re: [Ebtables-user] ebtables rules dont work
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: monade@freenet.de, ebtables-user@lists.sourceforge.net
Cc: bridge@lists.osdl.org

On Sunday 23 May 2004 11:44, monade@freenet.de wrote:
> Hello,<br>
> i have some problems with testing the ebtables on my machine.<br>
> It's a Vanilla Kernel 2.6.5 and I selected:<br>
> <br>
> - [*] 802.1d Ethernet Bridging<br>
> - Netfilter iptables option  <br>
> <br>
> and all ebtables options to compile new for a bridge machine.<br>
> This works sucesfully and i installed ebtables v2.0.6.<br>
> <br>
> Now my Problem is that all packets will be Droped in the Forward Chain.<br>
> It makes the appearance that it's unimportant wich rule i use.<br>
> <br>
> Here my very simple rule Setup only for testing:<br>
> ebtables -P FORWARD DROP<br>
> ebtables -P INPUT DROP<br>
> ebtables -P OUTPUT DROP<br>
> ebtables -A FORWARD -p IPv4 --ip-proto tcp --ip-sport 80 -j ACCEPT <br>
> <br>
> When i use iptables for filtering i can/must see the same effect. <br>

I don't exactly understand what your question is, but not all traffic that 
passes through the ebtables INPUT chain passes through the iptables INPUT 
chain. Only locally destined traffic (according to the IP destination 
address) goes through the iptables INPUT chain. Likewise, not all traffic 
that goes through the ebtables OUTPUT chain goes through the iptables OUTPUT 
chain. See http://ebtables.sourceforge.net/br_fw_ia/br_fw_ia.html for more 
details.

cheers,
Bart

