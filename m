Date: Sun, 8 Mar 2009 14:43:32 -0700
From: Ray Van Dolson <rayvd@bludgeon.org>
Message-ID: <20090308214331.GA14102@bludgeon.org>
References: <20090308164029.GA10137@bludgeon.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20090308164029.GA10137@bludgeon.org>
Subject: Re: [Bridge] Bridging via vtun...
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

On Sun, Mar 08, 2009 at 09:40:29AM -0700, Ray Van Dolson wrote:
> Hi all;
> 
> I'm trying to set up a bridge between two networks using vtun on Linux.
> It's almost working, but I'm running into an issue...

Just a note -- got this figured out.  The problem was that my vtun
endpoint was a VMware guest running in ESX.  The VMswitch was set to
Reject promiscuous mode which obviously means that the bridge code
won't work properly.

Also explains why I was only seeing broadcast traffic!

Ray
