Date: Wed, 10 Nov 2004 09:15:19 -0800
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [Bridge] Bridge utilities compatible driver
Message-Id: <20041110091519.64948657@zqx3.pdx.osdl.net>
In-Reply-To: <41917B5A.6020501@anu.edu.au>
References: <41917B5A.6020501@anu.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: ggb112 <gerard.borg@anu.edu.au>
Cc: bridge@lists.osdl.org

On Wed, 10 Nov 2004 13:22:18 +1100
ggb112 <gerard.borg@anu.edu.au> wrote:

> Hi guys
> 
> I am writing a serial network driver. My aim is to bridge two ethernets 
> across a serial bridge.
> Unfortunately the channel is noisy and slip and ppp are too unreliable.

Full stop.  Then bridging is not the answer. You need to have a reliable
(no corruption), packetized link to do bridging. Otherwise, you would
be introducing corrupted packets from you link onto the Ethernet you
are bridging onto. If you can't get ppp to work, then bridging it isn't
the answer.

> The driver appears to work by itself and allows two computers  to ping 
> each other across a
> null modem cable.
> 
> The network driver code permits Linux OS ARPing support for ethernet and 
>  MAC addresses
> are manually assigned by insmod.
> 
> The driver is based on  mkiss.c: the packet radio driver for serial ttys 
> except that I have eliminated
> ax25 specific code, interfaced to IP directly and added some ethernet 
> support.
> 
> Now the problem...
> 
> The network driver cannot be bridged to an ethernet card using the 
> bridge-utilities layer 2
> bridge tools.

The device has to say it does ethernet encapsulation, the addresses
and headers must be the same as ethernet.

> Note that I have  successfully bridged between the ethernet  card and 
> other  ethernet like hardware such as
> cisco pci340 WiFi by using these tools.
> 
> I am using bridge-utilities-0.9.6-1 on linux 2.4.18-14 and linux 2.20-8.
> 
> Any ideas about what I should include as software support in the driver 
> code that will make bridge-utilities
> happy?
> 
> What does bridge-utilities expect to have available to do its job?
> 
> Cheers
> 
> Gerard Borg
> Australian National Univesrity
> 
> 
> 
