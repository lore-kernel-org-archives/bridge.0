Return-Path: <pneira@us.es>
Date: Thu, 1 Mar 2012 14:03:11 +0100
From: Pablo Neira Ayuso <pablo@netfilter.org>
Message-ID: <20120301130311.GA7429@1984>
References: <1330593390-19233-1-git-send-email-santoshprasadnayak@gmail.com>
	<20120301101809.GA6488@1984>
	<CAOD=uF6yqCETUG8jMCmjYDM+L1DsM91OiRveONJkNxMf=skTSg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOD=uF6yqCETUG8jMCmjYDM+L1DsM91OiRveONJkNxMf=skTSg@mail.gmail.com>
Subject: Re: [Bridge] [PATCH 1/3] netfilter: Fix copy_to_user too small size
 parametre.
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: santosh prasad nayak <santoshprasadnayak@gmail.com>
Cc: netfilter@vger.kernel.org, coreteam@netfilter.org, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, davem@davemloft.net, bart.de.schuymer@pandora.be, netfilter-devel@vger.kernel.org, shemminger@vyatta.com, Dan Carpenter <dan.carpenter@oracle.com>

On Thu, Mar 01, 2012 at 04:15:05PM +0530, santosh prasad nayak wrote:
> Hi Pablo.
> 
> copy_to_user( dest, source, length)
> 
> Normally,  'length'  is equal to  'sizeof (source) '.
> 
> In this case "length"   =   32
>        "sizeof(source)"  =   29.
> 
> Is it intentional ?

ebtables expects 32 bytes names.

> Won't it copy extra 3 bytes of kernel data to userspace ?

You're right. We have to copy 29 bytes but we have to fill the
remaining bytes with zeroes. I think something like:

char name[EBT_FUNCTION_MAXNAMELEN] = {};

/* user-space ebtables expects 32 bytes-long names, but xt_match uses
 * 29 bytes for that. */
sprintf(name, "%s", m->u.match->name);
if (copy_to_user(hlp, name, EBT_FUNCTION_MAXNAMELEN))
...

will resolve this issue.

Would you resend a new patch?
