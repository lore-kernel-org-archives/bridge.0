Message-ID: <88240e9404100618443d96907e@mail.gmail.com>
Date: Wed, 6 Oct 2004 18:44:56 -0700
From: TEJAS VORA <voratejas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Bridge / Transparent Proxy
Reply-To: TEJAS VORA <voratejas@gmail.com>
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

Hi,

I am using my machine as a Bridge and running transparent proxy on it.
My question is - where the brdige will work?

Do brdige will forward the packet before it reaches to iptables rule?
If yes then what is the solution - as I want to use my machine as
Transparent proxy and I have setup iptables rules on it.

I have tried so many times - look at the tcpdump also - but it seems
that packets are not following iptables rule and just being forwarded
normally.

Config is : 

FTP server - 192.168.11.160
Bridge - 192.168.11.201

I have setup jftpgw FTP transparent proxy on bridge. Which listens on
port 2370. I have set a iptables rule

iptables -t nat -A PREROUTING -p tcp -d 0/0 -s 0/0 --dport 21 -J DNAT
--to 192.168.11.201:2370

Now I am trying to access FTP Server (192.168.11.160) from out side -
and checking the tcpdump on the Brdige (proxy) machine for port 2370 -
but nothingis coming up. Also on FTP machine the tcpdump shows direct
connection. So it seems my transparent porxy is not coming in between
and bridge is directly forwarding packet.

What is the solution to this problem?

Thanks,
Tejas
