Message-ID: <462B9243.6070804@linux-foundation.org>
Date: Sun, 22 Apr 2007 09:50:11 -0700
From: Stephen Hemminger <shemminger@linux-foundation.org>
MIME-Version: 1.0
Subject: Re: [Bridge] linux bridge does not bridge bpdu packets
References: <60846.193.196.136.17.1177202163.squirrel@sleon.dyndns.org>
In-Reply-To: <60846.193.196.136.17.1177202163.squirrel@sleon.dyndns.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: sleon@sleon.dyndns.org
Cc: bridge@lists.linux-foundation.org

Roman Glebov wrote:
> Hallo,
>
> i have here transparent linux based bridge.
>
> The problem is : all stp packets which come to one side of the Bridge are
> not forwarded to the other side. Which distrubs stp when this device is
> put inbetween of two stp capable devices.
> It forwards all traffik through it.
> Normal udp/tcp traffik is forwarded.
>
> I switched stp on it "off" so it does not participate in Spanning tree
> communications.
>
> It is a very simple setup :
> br0 with eth0 and eht1 as ports. without any additional firewall rules.
>
>
> I am using 2.6.18-4-686 debian kernel(testing).
>
> i even did setfd br0 0.
>
>
> What am i doing wrong ?
>
> Do i need to use ebtables to explicitely forward the traffic?
>   
Turn on STP in the bridge, it will then receive process and send it's 
own STP BPDU's.

