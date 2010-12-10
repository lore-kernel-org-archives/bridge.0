Date: Fri, 10 Dec 2010 23:52:27 +0100
From: Tobias Klauser <tklauser@distanz.ch>
Message-ID: <20101210225226.GL10190@distanz.ch>
References: <20101209082924.6d797871@nehalam>
	<1291903356-30618-1-git-send-email-tklauser@distanz.ch>
	<1291987084-27302-1-git-send-email-tklauser@distanz.ch>
	<20101210.130125.233714141.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20101210.130125.233714141.davem@davemloft.net>
Subject: Re: [Bridge] [PATCH v2] bridge: Fix return values
	of	br_multicast_add_group/br_multicast_new_group
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org

On 2010-12-10 at 22:01:25 +0100, David Miller <davem@davemloft.net> wrote:
> From: Tobias Klauser <tklauser@distanz.ch>
> Date: Fri, 10 Dec 2010 14:18:04 +0100
> 
> > If br_multicast_new_group returns NULL, we would return 0 (no error) to
> > the caller of br_multicast_add_group, which is not what we want. Instead
> > br_multicast_new_group should return ERR_PTR(-ENOMEM) in this case.
> > Also propagate the error number returned by br_mdb_rehash properly.
> > 
> > Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
> 
> Looks good, applied to net-next-2.6
> 
> Please in the future make is clear, in your subject line, which
> tree this patch is meant for.
> 
> I had to figure it out by trial and error, because this patch
> does not apply properly to net-2.6

Sorry about that. I'll do so in the future.

Thanks
