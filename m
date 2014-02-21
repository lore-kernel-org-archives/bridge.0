Return-Path: <mcgrof@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date:message-id
	:subject:to:cc:content-type;
	bh=n7hBoHr9WFc5t4zHypljSCl6cT3YgUdBu7ZXzeiU6ek=;
	b=j/5FpA2j5ZfVhBGCpXhsB39RSZh53nuqxiEc3turJZwNfR9vyX1QxUM5vfAOCaeFwH
	yfTIKjpnSpK5o6PXX5kfqNn7kk9kn4NokRy5GpEDa+PNc36Xq8QCPQUXA277z76GEm3Q
	pE+jz/ejgTMjw7lxTD7E5nXHP6RHqDBpE2dGkSmQQZpl1+kRq5nPkEJO2EEtkY0BeCaP
	pFaMtcMEtwWtTGzKUxsUdAzF65v0/BxiskVA70oviqVFDLGDXq0m+Y+tZ6ESpFecpIO2
	8ZWCMpIX/9e98CgzufV6YPdI7h/+PfZkpSjmZEXh3pZHKgl9zCZZmjF/h7D1cv+Wv7PW
	oOww==
MIME-Version: 1.0
Sender: mcgrof@gmail.com
In-Reply-To: <53074E6B.6030006@citrix.com>
References: <1392433180-16052-1-git-send-email-mcgrof@do-not-panic.com>
	<1392433180-16052-2-git-send-email-mcgrof@do-not-panic.com>
	<20140216105754.63738163@nehalam.linuxnetplumber.net>
	<CAB=NE6WwbOXNLO_Mn42i7y62pEsmDOWd35B621eiJk4iaE3Hfg@mail.gmail.com>
	<1392803559.23084.99.camel@kazak.uk.xensource.com>
	<5304C13F.3030802@citrix.com>
	<CAB=NE6X6Vuo3iib0W-c5cxv0QBpnZtCC0sFyuULugQoEZAbRtg@mail.gmail.com>
	<20140219090855.610c0e04@nehalam.linuxnetplumber.net>
	<CAB=NE6UAqoiFAJdckE1d7cgMZnU6_=8X+N=tSc6qH2bgH08M7Q@mail.gmail.com>
	<20140220091958.62a8b444@nehalam.linuxnetplumber.net>
	<CAB=NE6WnMFkH7JPNt+ROiWEvhvZ03vdGr21STf75DV9fRaK=PA@mail.gmail.com>
	<53074E6B.6030006@citrix.com>
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Fri, 21 Feb 2014 08:01:13 -0800
Message-ID: <CAB=NE6XR+FW2X2_nr2JAxgQD+zpm8=Xq7Y4fTf740rLhGCOzEw@mail.gmail.com>
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
Cc: Ian Campbell <Ian.Campbell@citrix.com>, kvm@vger.kernel.org, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, bridge@lists.linux-foundation.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Stephen Hemminger <stephen@networkplumber.org>, xen-devel@lists.xenproject.org

On Fri, Feb 21, 2014 at 5:02 AM, Zoltan Kiss <zoltan.kiss@citrix.com> wrote:
>> Agreed that's the best strategy and I'll work on sending patches to
>> brctl to enable the root_block preference. This approach however also
>
> I don't think brctl should deal with any Xen specific stuff. I assume there
> is a misunderstanding in this thread: when I (and possibly other Xen folks)
> talk about "userspace" or "toolstack" here, I mean Xen specific tools which
> use e.g. brctl to set up bridges. Not brctl itself.

I did mean brctl, but as I looked at the code it doesn't used
rtnl_open() and not sure if Stephen would want that. Additionally even
if it did handle root_block the other issue with this strategy is that
as you noted upon initialization the bridge, without a static MAC
address, could end up setting the backend as the root port, until you
let userspace turn the root_block knob.

  Luis
