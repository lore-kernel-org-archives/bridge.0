Message-ID: <fed120860807020937v1a6d42br5b3643b997801cfc@mail.gmail.com>
Date: Wed, 2 Jul 2008 22:07:53 +0530
From: "Srinivas M.A." <srinivas.aji@gmail.com>
In-Reply-To: <20080604211254.GB22523@linux-wlan.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20080604211254.GB22523@linux-wlan.com>
Subject: Re: [Bridge] [patch] data element sizes netlink fixes for rstpd
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Solomon Peachy <solomon@linux-wlan.com>
Cc: bridge@lists.linux-foundation.org

Sorry for the delayed reply.
Thanks for the fix.
I have applied this to my local git repository.

On Thu, Jun 5, 2008 at 2:42 AM, Solomon Peachy <solomon@linux-wlan.com> wrote:
> The attached patch, against Srinivas's git snapshot of May 7, fixes
> two releated problems.  The kernel's netlink handlers relating to the
> IFLA_OPERSTATE attribute use an 8-bit field, while the rstpd code was
> assuming a 32-bit integer.
>
> This might have worked on little-endian target, but the BE boxen I'm
> using crap all over the place with bogus numbers.
>
> With this patch, my BE boxen (with 2.6.22.x) come up and RSTP-away.
>
>  - Solomon
> --
> Solomon Peachy                        solomon@linux-wlan.com
> AbsoluteValue Systems                 http://www.linux-wlan.com
> 721-D North Drive                     +1 (321) 259-0737  (office)
> Melbourne, FL 32934                   +1 (321) 259-0286  (fax)
>
