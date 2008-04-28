Date: Mon, 28 Apr 2008 21:02:01 +0100 (BST)
From: Malcolm Scott <Malcolm.Scott@cl.cam.ac.uk>
In-Reply-To: <1209034195.3829.13.camel@koenws.oogziekenhuis.lan>
Message-ID: <alpine.DEB.1.10.0804282058311.5194@callisto.moose.malc.org.uk>
References: <1208985722.3713.2.camel@localhost.localdomain>
	<alpine.DEB.1.10.0804232358250.20981@callisto.moose.malc.org.uk>
	<1209034195.3829.13.camel@koenws.oogziekenhuis.lan>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Subject: Re: [Bridge] Set second IP on bridge
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Koen Vermeer <koen@vermeer.tv>
Cc: bridge@lists.linux-foundation.org

On Thu, 24 Apr 2008, Koen Vermeer wrote:

> I'm still strugling to get this incorporated in my
> Debian /etc/network/interfaces file, but I guess that's off-topic here.
> In case it isn't, or if you know the right place to ask about that,
> please let me know.

This should work:

auto br0:1
iface br0:1 inet static
   address ...
   netmask ...

(after your definition for br0)

Or alternatively

auto br0
iface br0 inet (...)
   ...
   up ip address add ... dev $IFACE
   down ip address del ... dev $IFACE

-- 
Malcolm Scott
Research Assistant
University of Cambridge Computer Laboratory

