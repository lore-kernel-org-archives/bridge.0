Date: Mon, 12 Jan 2009 12:06:50 -0800
From: Stephen Hemminger <shemminger@vyatta.com>
Message-ID: <20090112120650.41bb11b3@extreme>
In-Reply-To: <7B7881568CF40E4388B615CD06F87B9809885B@clara.maurer-it.com>
References: <531916880.118131231776345415.JavaMail.root@ken>
	<20090112093636.18525a7a@extreme>
	<7B7881568CF40E4388B615CD06F87B9809885B@clara.maurer-it.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] Prevent MAC address from changing
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Dietmar Maurer <dietmar@proxmox.com>
Cc: bridge@lists.linux-foundation.org

On Mon, 12 Jan 2009 20:51:14 +0100
"Dietmar Maurer" <dietmar@proxmox.com> wrote:

> > latest kernels have a way to set mac address. After setting mac
> address
> > of bridge device, then address won't change.
> 
> AFAIK the bridge code always uses the lowest MAC address, so setting the
> MAC address
> does not help. As soon as you add a port with a lower MAC the address 
> changes. Or did that behavior change recently?
> 
> - Dietmar
> 

If you manually configure an MAC address, it sticks as of 2.6.27
