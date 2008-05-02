Date: Fri, 2 May 2008 18:30:39 +0200
From: Bernhard Fischer <rep.dot.nop@gmail.com>
Message-ID: <20080502163039.GA9589@mx.loc>
References: <20080502090138.GA15508@mx.loc> <20080502081746.64e967bb@extreme>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080502081746.64e967bb@extreme>
Subject: Re: [Bridge] [RFA,
	PATCH] enable transition to sysfs-only bridge manipulation
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <shemminger@linux-foundation.org>
Cc: buytenh@gnu.org, rep.dot.nop@gmail.com, bridge@lists.linux-foundation.org

On Fri, May 02, 2008 at 08:17:46AM -0700, Stephen Hemminger wrote:
>On Fri, 2 May 2008 11:01:38 +0200
>Bernhard Fischer <rep.dot.nop@gmail.com> wrote:
>
>> Hi,
>> 
>> It was rumored that the ioctl interface for bridges is deprecated.
>> There is, however, one crucial gap when trying to implement brctl
>> without using any ioctl: AFAICS it is impossible to create a bridge via
>> sysfs.
>> 
>> The attached quick.. erm patch strives to fill this gap.
>> Some further details are at the top of the patchlet which received only
>> cursory testing, fwiw.
>> 
>> Thanks and cheers,
>> Bernhard
>
>Why bother. The old API has to live on because it part of the
>kernel ABI.

I'm bothering since i either want the ioctl interface _or_ the sysfs
interface. I currently use the ioctl interface but as long as the sysfs
is incomplete i cannot switch to it even if i wanted.
