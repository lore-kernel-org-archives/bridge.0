Date: Mon, 28 Apr 2008 20:57:56 +0100 (BST)
From: Malcolm Scott <Malcolm.Scott@cl.cam.ac.uk>
In-Reply-To: <2327.91.89.6.59.1209015008.squirrel@postamt.eit.uni-kl.de>
Message-ID: <alpine.DEB.1.10.0804282057310.5194@callisto.moose.malc.org.uk>
References: <2327.91.89.6.59.1209015008.squirrel@postamt.eit.uni-kl.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Subject: Re: [Bridge] Access the bridge through the userspace (Rx/Tx)
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Faruk Keskin <faruk@eit.uni-kl.de>
Cc: bridge@lists.linux-foundation.org

On Thu, 24 Apr 2008, Faruk Keskin wrote:

> I'm trying to implement Layer 2 packet processing, where I need  to
> transfer packets arriving at the Linux Bridge to a dedicated userspace
> application. So my very basic question would be whether you could
> recommend a strategy to achieve this.
>
> Can I use TUN/TAP or do I need to implement specific code around a socket?

You could alternatively use libpcap, if I understand your requirements 
properly.

-- 
Malcolm Scott
Research Assistant
University of Cambridge Computer Laboratory

