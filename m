Return-Path: <stephen@networkplumber.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
	h=date:from:to:cc:subject:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=h3IIt7XqOz/IWl9/kGhhZUhZqpYJm1DCRFWahUxp61A=;
	b=1HNr5tBrsBuhBPKnMC+wbKXnpgysC9JEaV9wdMt8g9u3KlXOOQfUmsYURqvRugh1FG
	p+99Idthl26aIuoxee/kiSo3l+P3OzKMwNs4EXwu9FIcKOCqYGth8Ap3ihfzlSuH5j4w
	C2nTTKsbHsFXsjUJqTFcKnRk7+1kKJAy2+h+/UGDZh5aGwCVwLugwgchtPgKEJ2u03Zx
	+PzGmzX2ai92yWCCiXZnao3ezTgKokOZkJxr+FaSqksllABBNKkb75ecwBsJBlRHFZ/6
	1mZPBFl9w7aMAMbnIWyGT3okajx89Y/ZjV3lzNpitEENoy3f+qCo5wCWg7S8e4+PwplA
	fxag==
Date: Tue, 12 Dec 2017 10:07:13 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
Message-ID: <20171212100713.6c24c9c3@xeon-e3>
In-Reply-To: <1513087370-4791-1-git-send-email-nikolay@cumulusnetworks.com>
References: <1513087370-4791-1-git-send-email-nikolay@cumulusnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next] net: bridge: use rhashtable for fdbs
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Cc: netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, davem@davemloft.net, srn@prgmr.com

On Tue, 12 Dec 2017 16:02:50 +0200
Nikolay Aleksandrov <nikolay@cumulusnetworks.com> wrote:

> Before this patch the bridge used a fixed 256 element hash table which
> was fine for small use cases (in my tests it starts to degrade
> above 1000 entries), but it wasn't enough for medium or large
> scale deployments. Modern setups have thousands of participants in a
> single bridge, even only enabling vlans and adding a few thousand vlan
> entries will cause a few thousand fdbs to be automatically inserted per
> participating port. So we need to scale the fdb table considerably to
> cope with modern workloads, and this patch converts it to use a
> rhashtable for its operations thus improving the bridge scalability.
> Tests show the following results (10 runs each), at up to 1000 entries
> rhashtable is ~3% slower, at 2000 rhashtable is 30% faster, at 3000 it
> is 2 times faster and at 30000 it is 50 times faster.
> Obviously this happens because of the properties of the two constructs
> and is expected, rhashtable keeps pretty much a constant time even with
> 10000000 entries (tested), while the fixed hash table struggles
> considerably even above 10000.
> As a side effect this also reduces the net_bridge struct size from 3248
> bytes to 1344 bytes. Also note that the key struct is 8 bytes.
> 
> Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
> ---

Thanks for doing this, it was on my list of things that never get done.

Some downsides:
 * size of the FDB entry gets larger.
 * you lost the ability to salt the hash (and rekey) which is important
   for DDoS attacks
 * being slower for small (<10 entries) also matters and is is a common
   use case for containers.


