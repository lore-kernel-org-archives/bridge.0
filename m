Return-Path: <vyasevich@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=message-id:date:from:user-agent:mime-version:to:cc:subject
	:references:in-reply-to:content-type:content-transfer-encoding;
	bh=HhrI1w2FWwGzdNKnvwnEdjpmzlSIuclwHI935yL6PlQ=;
	b=aiLQc6HMrjDsfIPLLHEnPrXlk/0eGu+CkO/B6QOLlKVrwJJ4N8bxfAoj1FgU0d3Ylt
	D8ejf7O77jKHRJ1jsaMPrPREfOyvRB2CrM3lTtCgRvrZvYpCkYiMCiByihkHRRmMDTP3
	mYo+mH3eHD4iqZ3yMFKCkD+I4lnjQO8Z3nIVc7+NFgCrfSWT3M11h6UlmlniJiuDbVOq
	Cz5MuySCygnClG93354GxWErlVsWvDyy63qcMAOGO36h5SNT16yKMT8XyzkIJJykwzoR
	lHl+dOimskNFiZS50P8UPPlrpr2Sb6ANuPLG5bTwkhqJE10mQir/qb9jJYJNGpwYbcdI
	Pz4w==
Message-ID: <52A27D6B.10508@gmail.com>
Date: Fri, 06 Dec 2013 20:44:11 -0500
From: Vlad Yasevich <vyasevich@gmail.com>
MIME-Version: 1.0
References: <1386257257-25258-1-git-send-email-jiri@resnulli.us>
	<20131205085514.4c079747@nehalam.linuxnetplumber.net>
	<52A135C2.9020406@cn.fujitsu.com>
In-Reply-To: <52A135C2.9020406@cn.fujitsu.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [patch net/stable v2] br: fix use of ->rx_handler_data
 in code executed on non-rx_handler path
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Gao feng <gaofeng@cn.fujitsu.com>, Stephen Hemminger <stephen@networkplumber.org>, Jiri Pirko <jiri@resnulli.us>
Cc: jtluka@redhat.com, mst@redhat.com, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, edumazet@google.com, laine@redhat.com, zhiguohong@tencent.com, davem@davemloft.net

On 12/05/2013 09:26 PM, Gao feng wrote:
> On 12/06/2013 12:55 AM, Stephen Hemminger wrote:
>> On Thu,  5 Dec 2013 16:27:37 +0100
>> Jiri Pirko <jiri@resnulli.us> wrote:
>>
>>> br_stp_rcv() is reached by non-rx_handler path. That means there is no
>>> guarantee that dev is bridge port and therefore simple NULL check of
>>> ->rx_handler_data is not enough. There is need to check if dev is really
>>> bridge port and since only rcu read lock is held here, do it by checking
>>> ->rx_handler pointer.
>>>
>>> Note that synchronize_net() in netdev_rx_handler_unregister() ensures
>>> this approach as valid.
>>>
>>
>>
>> I think this patch is simpler/better, it restores the old logic.
>>
>> Ps. submitting patches to bugzilla is a good way to have them ignored.
>>
>> >From Stephen Hemminger <stephen@networkplumber.org>
>>
>> Check that incoming STP packet is received on a port assigned to bridge
>> before processing. It is possible to receive packet on non-bridge port
>> because they are multicast.
>>
>> See:
>>  https://bugzilla.kernel.org/show_bug.cgi?id=64911
>>
>>
>> Regression introduced by:
>> commit 716ec052d2280d511e10e90ad54a86f5b5d4dcc2
>> Author: Hong Zhiguo <zhiguohong@tencent.com>
>> Date:   Sat Sep 14 22:42:28 2013 +0800
>>
>>     bridge: fix NULL pointer deref of br_port_get_rcu
>>
>>
>> Reported-by: Alexander Y. Fomichev
>> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
>>
>>
>> --- a/net/bridge/br_stp_bpdu.c	2013-06-11 09:50:21.522919061 -0700
>> +++ b/net/bridge/br_stp_bpdu.c	2013-12-05 08:46:56.090463702 -0800
>> @@ -153,6 +153,9 @@ void br_stp_rcv(const struct stp_proto *
>>  	if (buf[0] != 0 || buf[1] != 0 || buf[2] != 0)
>>  		goto err;
>>  
>> +	if (!br_port_exists(dev))
>> +		goto err;
>> +
>>  	p = br_port_get_rcu(dev);
>>  	if (!p)
>>  		goto err;
> 
> 
> We alreay did some cleanup jobs before mark this dev is not a port of bridge (dev->priv_flags &= ~IFF_BRIDGE_PORT),
> such as remove the fdb related to this port(br_fdb_delete_by_port).
> 
> and seems like after these cleanup jobs, before unregister this device, if new skb is received,
> br_handle_local_finish will call br_fdb_update to create a new fdb whose dst points to the will-be-destroied-port.

Not really.  We disable the port first before removing the fdb
as a result, br_handle_local_finish() will not update the fdb because
the port is in disabled state.

-vlad

> 
> I don't know if this will cause some problems.
> seems we should also make sure port is unavailable before we do cleanup.
> --
> To unsubscribe from this list: send the line "unsubscribe netdev" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

