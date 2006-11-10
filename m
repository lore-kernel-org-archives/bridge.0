Date: Fri, 10 Nov 2006 14:33:38 -0800
From: Stephen Hemminger <shemminger@osdl.org>
Message-ID: <20061110143338.446d5b91@freekitty>
In-Reply-To: <4554f533.18d37d8d.5d69.ffffc5a2@mx.google.com>
References: <4554f533.18d37d8d.5d69.ffffc5a2@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] bridge - canopy - cisco catalyst 2950
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: "Alonso Enero V." <alonso.enero@gmail.com>
Cc: bridge@lists.osdl.org, bridge@siennax.com

On Fri, 10 Nov 2006 18:54:49 -0300
"Alonso Enero V." <alonso.enero@gmail.com> wrote:

> Hi Friends!
> 
>  

>          
> 
>          Everything works ok in a laboratory environment, without the Cisco
> Catalyst switch, but when link the #1 bridge to the Cisco Catalyst
> respective port (the one with the needed VLAN), starts a horrible loop in
> our LAN. I think something happens inside the Cisco switch that difficult
> the STP traffic between the #1 bridge and out site 3. I heard of something
> called bdpufilter, which is not set in out Catalyst switch, said our ISP. I
> read a page were you give some suggestions of tweak the Linux Kernel that I
> did (http://lists.osdl.org/pipermail/bridge/2005-October/001116.html), but
> still didn't tested, until have a clear idea of what happens inside the
> Cisco switch.
> 
>  
Did you enable STP, it is off by default?


The version of Spanning Tree Protocol in Linux doesn't know about VLAN's,
so that might be related.


-- 
Stephen Hemminger <shemminger@osdl.org>
