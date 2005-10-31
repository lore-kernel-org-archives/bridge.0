Date: Mon, 31 Oct 2005 09:41:06 -0800
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [Bridge] device eth0 is already a member of a bridge;	can't
	enslave it to bridge Net6
Message-ID: <20051031094106.7294520d@dxpl.pdx.osdl.net>
In-Reply-To: <001701c5de02$7f634440$6502a8c0@tim>
References: <001701c5de02$7f634440$6502a8c0@tim>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

On Mon, 31 Oct 2005 11:04:32 +0100
"Tim Keupen" <timbub@uni-koblenz.de> wrote:

> Hello,
> I am working on Network-Simulation (VNUML). Our simulator uses linux bridging to connect the UMLs.
> So there is one problem:
> The example is the following: There are two hosts simulating one big net.
> The two hosts have connection over the external nets Net3 and Net6 (see http://www.uni-koblenz.de/~timbub/verteilteSim3.GIF), but in fact there is only one physical connection between the host: connected through a switch an each host has one interface card eth0. (so normaly you should bind the ip adresses related Net3 and to Net6 to the eth0 and it already is part of the two nets - even if there is one phsical connection)

Have you looked at umlsim

> So my virtual nets are implemented by linux bridges. But if I now connect the physical interface eth0 to the bridge Net3 and then to Net6 the following error occurs: "device eth0 is already a member of a bridge; can't enslave it to bridge Net6" 
> Is this a bug or a feature? Why is it not allowed to bind an Interface to two different bridges? 
> Is there a workaround for this issue?
> 
> 
> Problem: 
> UML1 ---- bridge1  \
>                              eth0  
> UML2 ---- bridge2  /
> 
> 
> Workaround?:
> UML1 ---- bridge1  \
>                              bridge3 ---- eth0
> UML2 ---- bridge2  /
> 
> 
> UML1   \
>              bridge1 ---- eth0
> UML2   /
> 

There was no good reason to allow it, I guess. Also, I would worry about races on deleting
a bridge and the RCU issues.


-- 
Stephen Hemminger <shemminger@osdl.org>
OSDL http://developer.osdl.org/~shemminger
