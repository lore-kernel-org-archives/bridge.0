Message-ID: <88240e9404101711465b4f0f6b@mail.gmail.com>
Date: Sun, 17 Oct 2004 11:46:12 -0700
From: TEJAS VORA <voratejas@gmail.com>
Subject: Re: [Bridge] Bridge / Transparent Proxy
In-Reply-To: <88240e94041015202366a6b6a6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <88240e9404100618443d96907e@mail.gmail.com>
	<1097275463.16787.110.camel@localhost.localdomain>
	<88240e94041015202366a6b6a6@mail.gmail.com>
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

I am sending you the ASCII pic with this mail - which has some idea
about configuration.

Bridge Machine (br0) IP : 192.168.11.201
(Gateway machine / need to be used as Transparent proxy)
       +---------------------------------------------+
       |                       |
       |                       |
       |                       |
       |                       |
       |                       |
       |                       |
       +---------------------------------------------+
               |       |
               eth0    eth1
               |       |
               |       |
               |       | FTP Content Server (192.168.11.60)
               |       +------------------------>
               |
               |
               |
               | TO INTRANET / INTERNET
               +-------------------------------->

People tries to access the FTP Content Server from Intranet and
Internet Side. The Bridge machine is running on Bridge Mode and
Transpwerent Proxy.

For passing packets to T-PROXY, I have setup IPTABLES rules like -

iptables -t nat -A PREROUTING -p tcp -d 0/0 -s 0/0 --dport 21 -J DNAT
--to 192.168.11.201:2370

But it seems that packet is forwarded by Brdige before it reaches the
iptables rule and thus T-PROXY tool is not able to process the packet.

Also, I am running Redhat 7.3 with kernel 2.18-3 and iptables 1.2.5
version. I am using the latest bridge utils - and while I run brdige
utils and setup iptables rule together - the kernel panics saying

Aiee - Killing interrupt handler
interrupt - no syncing

What should I do to handle these two problems - please reply asap.

Thanks fopr help
Tejas Vora



On Fri, 08 Oct 2004 15:44:23 -0700, Stephen Hemminger
<shemminger@osdl.org> wrote:
> On Wed, 2004-10-06 at 18:44 -0700, TEJAS VORA wrote:
> > Hi,
> >
> > I am using my machine as a Bridge and running transparent proxy on it.
> > My question is - where the brdige will work?
>
>
> What does the it look like in more detail.  What are machine's
> interfaces and IP addresses, more config info or picture (ASCII).
>
>
> > Do brdige will forward the packet before it reaches to iptables rule?
> > If yes then what is the solution - as I want to use my machine as
> > Transparent proxy and I have setup iptables rules on it.
> >
> > I have tried so many times - look at the tcpdump also - but it seems
> > that packets are not following iptables rule and just being forwarded
> > normally.
> >
> > Config is :
> >
> > FTP server - 192.168.11.160
> > Bridge - 192.168.11.201
> >
> > I have setup jftpgw FTP transparent proxy on bridge. Which listens on
> > port 2370. I have set a iptables rule
> >
> > iptables -t nat -A PREROUTING -p tcp -d 0/0 -s 0/0 --dport 21 -J DNAT
> > --to 192.168.11.201:2370
> >
> > Now I am trying to access FTP Server (192.168.11.160) from out side -
> > and checking the tcpdump on the Brdige (proxy) machine for port 2370 -
> > but nothingis coming up. Also on FTP machine the tcpdump shows direct
> > connection. So it seems my transparent porxy is not coming in between
> > and bridge is directly forwarding packet.
> >
> > What is the solution to this problem?
> >
> > Thanks,
> > Tejas
> > _______________________________________________
> > Bridge mailing list
> > Bridge@lists.osdl.org
> > http://lists.osdl.org/mailman/listinfo/bridge
>
>
