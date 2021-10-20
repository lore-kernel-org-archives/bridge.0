Return-Path: <liuhangbin@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=ftphP/rRhj3HAi/sY+WrPVk0b2hRaTcyx6DeAasFrXQ=;
 b=B0CIzVA8hGKlxBlbLI2TXw1a7ZZ4cI4SHyOME6mYX/zv8h4K7atw3/cZ4aDOymv95H
 3X5Vg7NcqP2XVepAF19Wi7bXeCwcTyJNS4yhadeU5Yel9wMMCqgaqG/kbZboDs3juflh
 OE4H7vqblU4SZteOWMPRSoradW0IED43Y4hJoBd/vB0TF3QdJelCYOyl4TRKsJ2w0Fil
 H/LEvKfwxRdcV3teg2VNyy6KOYPaPnZ7GwhPlAPYg/UYt7Rc8/5J5YEB0C///25Qz+23
 YAtZl6d8tjINLeAZV+twu5jaS3jbnj992LyKB5XZKTG0FSmplO5f+K9RWcH8Gt9V7S0M
 BhIQ==
Date: Wed, 20 Oct 2021 20:10:04 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
Message-ID: <YXAHHBYtFfXbd1hE@Laptop-X1>
References: <20211020023604.695416-1-liuhangbin@gmail.com>
 <20211020024016.695678-1-liuhangbin@gmail.com>
 <c041a184-92cb-0ebd-25e9-13bfc6413fc9@nvidia.com>
 <YW/tLekS17ZF9/w1@Laptop-X1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YW/tLekS17ZF9/w1@Laptop-X1>
Subject: Re: [Bridge] [PATCHv2 net] net: bridge: mcast: QRI must be less
	than QI
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <nikolay@nvidia.com>
Cc: netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, roopa@nvidia.com, kuba@kernel.org, davem@davemloft.net

On Wed, Oct 20, 2021 at 06:19:25PM +0800, Hangbin Liu wrote:
> On Wed, Oct 20, 2021 at 12:49:17PM +0300, Nikolay Aleksandrov wrote:
> > Nacked-by: Nikolay Aleksandrov <nikolay@nvidia.com>
> > 
> > I think we just discussed this a day ago? It is the same problem -
> > while we all agree the values should follow the RFC, users have had
> > the option to set any values forever (even non-RFC compliant ones).
> > This change risks breaking user-space.
> 
> OK, I misunderstood your reply in last mail. I thought you only object to
> disabling no meaning values(e.g. set timer to 0, which not is forbid by the
> RFC). I don't know you also reject to follow a *MUST* rule defined in the RFC.

I know you denied the patch due to user-space compatibility. Forgive me
if my last reply sound a little aggressive.

Thanks
Hangbin
