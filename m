Message-ID: <fed120860807022310t5039a5efx455de5f31fa7b71b@mail.gmail.com>
Date: Thu, 3 Jul 2008 11:40:23 +0530
From: "Srinivas M.A." <srinivas.aji@gmail.com>
In-Reply-To: <20080702202357.GC21344@linux-wlan.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20080604211254.GB22523@linux-wlan.com>
	<fed120860807020937v1a6d42br5b3643b997801cfc@mail.gmail.com>
	<20080702202357.GC21344@linux-wlan.com>
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

On Thu, Jul 3, 2008 at 1:53 AM, Solomon Peachy <solomon@linux-wlan.com> wrote:
> On Wed, Jul 02, 2008 at 10:07:53PM +0530, Srinivas M.A. wrote:

> Have there been any other changes since the last snapshot you published?

Nothing of significance. I put in a slightly simpler bridge-stp script.

>
> We've had some unexplained crashes of rstpd that I'm trying to diagnose
> now, but my gut feeling is that there are other endian-related bugs in
> the codebase.

Possible, we have only tested on x86 and x86_64.
If you can send me backtraces of the crashes, I will try and debug.
