Date: Fri, 15 Aug 2008 21:17:27 +0100 (BST)
From: Malcolm Scott <Malcolm.Scott@cl.cam.ac.uk>
In-Reply-To: <48A5E1E3.5060907@free.fr>
Message-ID: <alpine.DEB.1.10.0808152114540.27001@callisto.moose.malc.org.uk>
References: <48A0B4AD.6030703@free.fr> <20080811163159.49cf9980@extreme>
	<48A5E1E3.5060907@free.fr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Subject: Re: [Bridge] frame destinated to individual port MAC address
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Benoit PAPILLAULT <benoit.papillault@free.fr>
Cc: Bridge@lists.linux-foundation.org

At 22:06 today, Benoit PAPILLAULT wrote:

> I am in a very preliminary phase, trying to learn how to implement
> routing and bridging under Linux. In order for the routing protocol to
> have proper topology view, it somehow needs to assign a unique IP on all
> interfaces and for bridging and those interfaces needs to be in the same
> bridge.

By my understanding (and it's a while since I read that paper so I might be 
wrong) you don't need unique IP addresses on all interfaces; everything uses 
MAC addresses.  To quote section 4.2 of the draft:

    o  it runs directly over Layer 2, so therefore may be run with zero
       configuration (no IP addresses need to be assigned)

-- 
Malcolm Scott
Research Assistant
University of Cambridge Computer Laboratory

