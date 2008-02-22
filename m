Date: Fri, 22 Feb 2008 12:49:53 -0800
From: Stephen Hemminger <shemminger@linux-foundation.org>
Message-ID: <20080222124953.7629cc3d@extreme>
In-Reply-To: <eab08af20802221231w35d80434ie9bda84bafcd342c@mail.gmail.com>
References: <eab08af20802221231w35d80434ie9bda84bafcd342c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] bridge-utils-1.4 unknown symbols
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: jieryn@gmail.com
Cc: bridge@lists.linux-foundation.org

On Fri, 22 Feb 2008 15:31:30 -0500
jieryn@gmail.com wrote:

> Greetings,
> 
> I'm on a Gentoo vanilla-sources-2.6.24.2 kernel, with
> bridge-utils-1.4installed. When I try to modprobe bridge dmesg shows:
> 
> Feb 22 15:22:51 indigo bridge: Unknown symbol br_handle_frame_hook
> Feb 22 15:22:51 indigo bridge: Unknown symbol nf_register_hooks
> Feb 22 15:22:51 indigo bridge: Unknown symbol br_fdb_put_hook
> Feb 22 15:22:51 indigo bridge: Unknown symbol nf_unregister_hooks
> Feb 22 15:22:51 indigo bridge: Unknown symbol nf_hook_slow
> Feb 22 15:22:51 indigo bridge: Unknown symbol br_fdb_get_hook
> 
>

Your kernel wasn't built with bridging enabled. You can't just build the
bridge module standalone, the kernel itself needs to include bridging.

Save your kernel config and then rebuild:

cp .config config.sav
make mrproper
make

