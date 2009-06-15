Date: Sun, 14 Jun 2009 20:49:15 -0700
From: Stephen Hemminger <shemminger@vyatta.com>
Message-ID: <20090614204915.0a9a4187@nehalam>
In-Reply-To: <6d6e77f50906140128t65853593y61bf65c200970864@mail.gmail.com>
References: <6d6e77f50906140128t65853593y61bf65c200970864@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] bridge module insertion
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: eko suwarsono <ekoswr76@gmail.com>
Cc: bridge@lists.linux-foundation.org

On Sun, 14 Jun 2009 16:28:36 +0800
eko suwarsono <ekoswr76@gmail.com> wrote:

> dear all
> I'm newbie on this. but i need the advise for this problem. sorry if this
> already in archive
> 
> I had embedded system from vendor using ubuntu 7.  with kernel 2.6.20.4 the
> system is on CF card
> i need to have the bridge module on that systems, the problem there is no
> compiler,etc. very minimum system
> so what i did is install ubuntu on another PC and using exactly the same
> kernel, gcc version etc to get the kernel with bridge module and then
> copying all /boot folders and /lib/modules onto my embedded system
> 
> the bridge module get error: insmod: error inserting bridge.ko : unknown
> symbol
> 
> at dmesg
> 
> bridge: Unknown symbol br_handle_frame_hook
> 
> 
> 
> is there any way to solve this problem, without rebuilding all OS on CF card

If the kernel itself was not built with bridging configured, then
the hook for the bridge won't be in the receive code in the kernel.

So basically you are out of luck, building bridge out of tree.
You need to get kernel source for the whole embedeed system, reconfigure
and rebuild.

-- 
