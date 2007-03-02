Message-ID: <45E7B37E.1000004@linux-foundation.org>
Date: Thu, 01 Mar 2007 21:17:50 -0800
From: Stephen Hemminger <shemminger@linux-foundation.org>
MIME-Version: 1.0
References: <OF97BBF83B.63D39BA2-ON65257292.0015130A-65257292.0015131B@mahln	hub.mahyco.com>
In-Reply-To: <OF97BBF83B.63D39BA2-ON65257292.0015130A-65257292.0015131B@mahln	hub.mahyco.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] Need Help
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Mangesh.Kulkarni@mahyco.com
Cc: bridge@linux-foundation.org, kulkarni.mangesh@hotmail.com

Mangesh.Kulkarni@mahyco.com wrote:
> Dear Stephen,
> Please help me to sortout the problem discussed below.
>  
> Thank You
> Mangesh H. Kulkarni
> Hardware Group
> Mahyco Seeds Ltd.
> Jalna.
> "For The World You Are Someone, But For Someone You Are The World"
>
> -----Mangesh Kulkarni/DWD/IT/SHS/MahycoGroup wrote: -----
>
>     To: bridge@osdl.org
>     From: Mangesh Kulkarni/DWD/IT/SHS/MahycoGroup
>     Date: 01/03/2007 04:57PM
>     cc: kulkarni.mangesh@hotmail.com
>     Subject: Need Help
>
>     Dear Sir,
>     I have configured broadband modem on windows xp prof. pc for
>     internet use and able to use internet. But when i am connecting
>     the same configured modem on RedHat Linux 8.0, no getting internet.
>     I have following setup on linux server:-
>     eth0 lan card is having ip address 192.168.100.5 with subnet mask
>     255.255.255.0.
>     ( I am connecting local lan on this card)
>     eth1 lan card is having ip address 192.168.1.10 with subnet mask
>     255.255.255.0
>     ( internet modem is connceted to this card)
>     I am also able to ping the IP address which i get from ISP. e.g
>     59.95.96.210 but not able to ping any web site.
>     Please help me to sove this problem.
>     Thank You
>     Mangesh H. Kulkarni
>     Hardware Group
>     Mahyco Seeds Ltd.
>     Jalna.
>     "For The World You Are Someone, But For Someone You Are The World"
>
>
It doesn't sound like you are bridging. Sounds like you are trying to do 
NAT (ebtables).
or some other routing.
