Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=subject:to:cc:references:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=5JYt2qMk1FeOX/LWPAKUk+TY4suhhrWYRUze0iqiLMk=;
	b=D1GPGgspajcrYQJDF40ZgSYzk5OU9AvSdQaskw1WtZKkY2W6AMYRPL9jGlYCOtpZX0
	G6WrrXaaTAhhCcjNoJDpzQWhJpFyMGQSvDp+17bsQLnlofAsV7PU82II5MeaZzzDNo2+
	lT2QsEVncPMmSjrT/ge4FQ9Gqy+/GrJfglGms=
References: <20180926121802.27851-1-nikolay@cumulusnetworks.com>
	<20180926121802.27851-10-nikolay@cumulusnetworks.com>
	<20180926133014.GA31563@splinter>
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <54917489-964b-76b3-82c7-a82b41d474b2@cumulusnetworks.com>
Date: Wed, 26 Sep 2018 16:35:49 +0300
MIME-Version: 1.0
In-Reply-To: <20180926133014.GA31563@splinter>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 9/9] net: bridge: pack net_bridge
	better
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ido Schimmel <idosch@idosch.org>
Cc: netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, davem@davemloft.net

On 26/09/18 16:30, Ido Schimmel wrote:
> On Wed, Sep 26, 2018 at 03:18:02PM +0300, Nikolay Aleksandrov wrote:
>> Further reduce the size of net_bridge with 8 bytes and reduce the number of
>> holes in it:
>>  Before: holes: 5, sum holes: 15
>>  After: holes: 2, sum holes: 3
>>
>> Also as a bonus we get offload_fwd_mark in the first cache line and remove
>> the need to pull the last cache line of net_bridge just for that member in
>> fast path (should_deliver -> nbp_switchdev_allowed_egress).
> 
> But nbp_switchdev_allowed_egress() compares with 'offload_fwd_mark' from
> 'net_bridge_port', not 'net_bridge'...
> 

ha, right you are! I need to check my glasses :) Anyway, I'll correct my
commit message and resend v2. We can leave the net_bridge mark in the
end, there're 4 bytes there anyway.

I was thinking of net_bridge_port, but that is a different patch-set I
have. Apparently I've mixed the commit messages.

Thanks!

