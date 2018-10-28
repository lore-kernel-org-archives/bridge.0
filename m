Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=subject:to:cc:references:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=M8tzr5OEk6xWjK/2ZrgZK+cpg/3Bs42aF1L/QfemlU4=;
	b=hSxiDe787VFTmWvKAYG9F4ExUXuf1qcGJ3Ts08bCLyI9W+y1vwPQ4jX6vsD6xovB8a
	JIQYdOOtFuV8C+thrpUUhQW2RBnWDOb+q1InKfdQA+zfrsOvPF/TQKZKLxabVNf+Iww+
	XznAvFKRM3XSYP8MwKsqJYL7GqhP2Y2bDVxiI=
References: <90c5f2fe-1743-6b17-2e44-eba58cdbbb35@cumulusnetworks.com>
	<20181027090747.22104-1-nikolay@cumulusnetworks.com>
	<20181028082023.222fac71@xeon-e3>
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <a9264998-9d98-3f70-1459-4bae2ac10e36@cumulusnetworks.com>
Date: Sun, 28 Oct 2018 18:09:06 +0200
MIME-Version: 1.0
In-Reply-To: <20181028082023.222fac71@xeon-e3>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net] net: bridge: remove ipv6 zero address
 check in mcast queries
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, yinxu@redhat.com, liuhangbin@gmail.com, davem@davemloft.net

On 28/10/2018 17:20, Stephen Hemminger wrote:
> On Sat, 27 Oct 2018 12:07:47 +0300
> Nikolay Aleksandrov <nikolay@cumulusnetworks.com> wrote:
> 
>> Recently a check was added which prevents marking of routers with zero
>> source address, but for IPv6 that cannot happen as the relevant RFCs
>> actually forbid such packets:
>> RFC 2710 (MLDv1):
>> "To be valid, the Query message MUST
>>  come from a link-local IPv6 Source Address, be at least 24 octets
>>  long, and have a correct MLD checksum."
>>
>> Same goes for RFC 3810.
>>
>> And also it can be seen as a requirement in ipv6_mc_check_mld_query()
>> which is used by the bridge to validate the message before processing
>> it. Thus any queries with :: source address won't be processed anyway.
>> So just remove the check for zero IPv6 source address from the query
>> processing function.
>>
>> Fixes: 5a2de63fd1a5 ("bridge: do not add port to router list when receives query with source 0.0.0.0")
>> Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
> 
> What about a broken/malicious sender? Could an all zero source be used
> to poison the multicast table?
> 

No, this has nothing to do with the table. This is about marking routers
and we shouldn't consider queries with src 0.0.0.0 (the original fix)
but for IPv6 such query is invalid and in fact doesn't reach that code at all.
As I've written in the commit message, ipv6_mc_check_mld_query() already checks
for that and marks it as invalid thus it isn't processed and we can drop that
check from the bridge mcast code, if you test with such src you can see in
the bridge mcast statistics that the MLD errors are going up showing that these
packets are treated as errors.

Thanks,
 Nik

