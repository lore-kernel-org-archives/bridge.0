Date: Fri, 04 Jun 2004 21:33:48 +0200
From: Derek Ditch <derek.ditch@us.army.mil>
In-reply-to: <200406040729.i547TgCp019626@ns.bginfo.net>
Message-id: <1A1E00DA-B65E-11D8-800E-000A95BC99E4@us.army.mil>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=US-ASCII
Content-transfer-encoding: 7BIT
References: <200406040729.i547TgCp019626@ns.bginfo.net>
Subject: [Bridge] Re: re : atheros bridge problem
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

I'm not sure how this particular solution works for my arrangement.  I 
have two 10/100 ethernet interfaces on the local net and one atheros 
interface.  I understand the issues w/ the 802.11a/b/g/i protocols, but 
this particular solution sounds as if I want to bridge two networks 
that are separated by a network segment, like a VPN.  But I have all 
these interfaces on one machine that I want bridged.  Also, it appears 
as if the two ethernet interfaces aren't forwarding traffic to each 
other either.  I am currently attached to an access point that is 
directly connected to one ethernet interface.  I can ping and establish 
an HTTP connection to that AP.  I can also ping and establish 
connections with the linux gateway router/bridge.  I cannot, however, 
pass any IP traffic past the linux/router to the AP on the other end, 
unless I move to use that AP instead.  The linux router can access both 
access points and there is no problem with externally routed traffic.

Also, I was wondering, one of the AP's I have is the ASUS WL300g.  This 
is a linux based router/ap.  It bridges the wifi interface and the 
ethernet interface.  I was curious if anyone knew how this worked?

Thanks,

Derek


On 04 Jun 2004, at 09:32, Krasiyan Andreev wrote:

>
>
> hi
> problem are well defined and known
> seems you are not reading it ... so explanation are described at
> http://bruno.pmi.lv/mailman/public/routeros/2003-May/001924.html
> and solution at
> http://www.mikrotik.com/Documentation/HowTo.html#How_bridge
> if you want to use opensource linux distribution , not commersial one 
> , only
> change kind of tunneling protocol from eoip to tap ( 
> http://vtun.sf.net)
> if you dont understand something , feel free to mail me for detailed 
> instructions
> but , I am sure that that point of description will be enough
>                         regards , Krasiyan
>
>
> ---------------------------------------------
> This message was sent using ComNet WebMail Server.
> http://www.bginfo.net/mail/
>
>

