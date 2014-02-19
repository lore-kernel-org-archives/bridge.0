Return-Path: <mcgrof@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date:message-id
	:subject:to:cc:content-type;
	bh=bf84TwENRT73uNR5foytN/JzPTBCQoX5paVvcSIZpHs=;
	b=QNdKiTJ7l8+5BaDx/EfLz4V4ClYRjlxa6Prfl2J0ZIObEpeNDWgdLVgEvFN1ThVbxB
	DXlTNu0/cDDbqWUJAgIyb1dey+xHXznjOZaCP0pJns2+sRVStNEE+Zbv6dxKD5d/+M0u
	64LDKmrf3tSgxV0lk8l/L+WsX354iuCHB9tOXIYFFR0eqh+zwC9LpX0W8UUzCf1YCbVT
	hH3yli9cBLk3js1KfeD0dwl5osV8zNfTNAfp5uOrdPfbhUCTOQu5v5kPzVJYNg2Q4An7
	D/pdRjSBxV+3Wztm3M9w0VvSwB8W6/nGMLAU6DVRSs35otdv7wsxSSmO3W28X1HqhOgv
	HCCg==
MIME-Version: 1.0
Sender: mcgrof@gmail.com
In-Reply-To: <53024C58.4010900@citrix.com>
References: <1392433180-16052-1-git-send-email-mcgrof@do-not-panic.com>
	<1392433180-16052-2-git-send-email-mcgrof@do-not-panic.com>
	<53024C58.4010900@citrix.com>
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Wed, 19 Feb 2014 08:45:55 -0800
Message-ID: <CAB=NE6XYjOd2vRpQCZOG-S5ZW4xjam+FOPAYzribNQpb50Q5pg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Bridge] [Xen-devel] [RFC v2 1/4] bridge: enable interfaces to
 opt out from becoming the root bridge
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Zoltan Kiss <zoltan.kiss@citrix.com>
Cc: kvm@vger.kernel.org, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, bridge@lists.linux-foundation.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Stephen Hemminger <stephen@networkplumber.org>, xen-devel@lists.xenproject.org

On Mon, Feb 17, 2014 at 9:52 AM, Zoltan Kiss <zoltan.kiss@citrix.com> wrote:
> On 15/02/14 02:59, Luis R. Rodriguez wrote:
>>
>> From: "Luis R. Rodriguez" <mcgrof@suse.com>
>>
>> It doesn't make sense for some interfaces to become a root bridge
>> at any point in time. One example is virtual backend interfaces
>> which rely on other entities on the bridge for actual physical
>> connectivity. They only provide virtual access.
>
> It is possible that a guest bridge together to VIF, either from the same
> Dom0 bridge or from different ones. In that case using STP on VIFs sound
> sensible to me.

You seem to describe a case whereby it can make sense for xen-netback
interfaces to end up becoming the root port of a bridge. Can you
elaborate a little more on that as it was unclear the use case.

Additionally if such cases exist then under the current upstream
implementation one would simply need to change the MAC address in
order to enable a vif to become the root port.  Stephen noted there is
a way to avoid nominating an interface for a root port through the
root block flag. We should use that instead of the MAC address hacks.
Let's keep in mind that part of the motivation for this series is to
avoid a duplicate IPv6 address left in place by use cases whereby the
MAC address of the backend vif was left static. The use case your are
explaining likely describes the more prevalent use case where address
conflicts can occur, perhaps when administrators for got to change the
backend MAC address. If we embrace a random MAC address we'd avoid
that issue, and but we'd need to update userspace to use the root
block on topologies where desired.

  Luis
