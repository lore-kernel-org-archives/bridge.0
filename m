Date: Fri, 19 Oct 2007 12:09:54 +0100 (BST)
From: Malcolm Scott <Malcolm.Scott@cl.cam.ac.uk>
Subject: Re: [Bridge] firewalling a VM
In-Reply-To: <787b0d920710182048s3f8627dek6b6b816897951415@mail.gmail.com>
Message-ID: <alpine.DEB.0.9999.0710191203480.13692@callisto.moose.malc.org.uk>
References: <787b0d920710182048s3f8627dek6b6b816897951415@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8; format=flowed
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Albert Cahalan <acahalan@gmail.com>
Cc: bridge@lists.linux-foundation.org

At 23:48 yesterday, Albert Cahalan wrote:

> Diagrams of packet flow through the kernel would help, even if that means 
> a man page with ASCII art.

I don't think a man page is the best place for that really... and such 
things already exist in documentation elsewhere:

http://ebtables.sourceforge.net/br_fw_ia/PacketFlow.png
http://ebtables.sourceforge.net/br_fw_ia/br_fw_ia.html


> That just kills my net connection. Note that I never
> told my host machine to route via the bridge device.
> As far as I'm concerned, it ought to still be using eth0.

But the ebtables rules don't just apply to the bridge.  They will most 
likely be applied to the rest of your traffic too.  If you want to confine 
them to that bridge, say so using using --logical-in & --logical-out or 
whatever.

-- 
Malcolm Scott
Research Assistant
University of Cambridge Computer Laboratory

