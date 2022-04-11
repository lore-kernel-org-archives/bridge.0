Return-Path: <razor@blackwall.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=v4z7ciQz0pMAhP2xoz2akjfMI+qQ/Mok6WikmTBqsYw=;
 b=tExJp+KgFpJ4L78z/xw5eqoIi0XRxRVIvDLn5hd6ER/6T0J9opCve52t/72GZK1QEs
 oMNTPbuOztVr9urcUkXJ2jwDFtD9Npi9NyjTezw4nXQvLHLZHafc9/Law32cc9yzt9kK
 nOHUQBLkhaq8dNPs4Qx73mDAtPZJwUvS7/zf+/EP+vhZ4WrqxADruiqxUyOtNk3DcooQ
 ayi0IziFBArzr866houQ8yQU9ihW2YQCQH3Uo/2gWW44DXN5g6xEKzAtu9cPoYYjzK9+
 kswhfTkuBRTOa1gy9V3Ce2Q8bClVQ+Q/df/8X8sDISMWP05PYBLR7rhchelPT0lpned6
 f+wg==
Message-ID: <61e817f3-8d06-b190-6023-1b89e05e4482@blackwall.org>
Date: Mon, 11 Apr 2022 12:05:48 +0300
MIME-Version: 1.0
Content-Language: en-US
References: <20220409105857.803667-1-razor@blackwall.org>
 <20220409105857.803667-4-razor@blackwall.org> <YlPpqKFeAs5oCHGD@shredder>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <YlPpqKFeAs5oCHGD@shredder>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 3/6] net: bridge: fdb: add new nl
 attribute-based flush call
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ido Schimmel <idosch@idosch.org>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, davem@davemloft.net, kuba@kernel.org, roopa@nvidia.com

On 11/04/2022 11:41, Ido Schimmel wrote:
> On Sat, Apr 09, 2022 at 01:58:54PM +0300, Nikolay Aleksandrov wrote:
>> diff --git a/include/uapi/linux/if_bridge.h b/include/uapi/linux/if_bridge.h
>> index 221a4256808f..2f3799cf14b2 100644
>> --- a/include/uapi/linux/if_bridge.h
>> +++ b/include/uapi/linux/if_bridge.h
>> @@ -807,7 +807,15 @@ enum {
>>  /* embedded in IFLA_BRIDGE_FLUSH */
>>  enum {
>>  	BRIDGE_FLUSH_UNSPEC,
>> +	BRIDGE_FLUSH_FDB,
>>  	__BRIDGE_FLUSH_MAX
>>  };
>>  #define BRIDGE_FLUSH_MAX (__BRIDGE_FLUSH_MAX - 1)
>> +
>> +/* embedded in BRIDGE_FLUSH_FDB */
>> +enum {
>> +	FDB_FLUSH_UNSPEC,
> 
> BTW, is there a reason this is not called FLUSH_FDB_UNSPEC given it's
> embedded in BRIDGE_FLUSH_FDB, which is embedded in IFLA_BRIDGE_FLUSH ?
> 
> Regardless, in the cover letter you have '[ BRIDGE_FDB_FLUSH ]', which
> is actually BRIDGE_FLUSH_FDB. I only noticed it because the code didn't
> match what I had in my notebook, which I copied from the cover letter :)
> 

Oops, that's a mismatch between an older version of the set and this one. :)

>> +	__FDB_FLUSH_MAX
>> +};
>> +#define FDB_FLUSH_MAX (__FDB_FLUSH_MAX - 1)
>>  #endif /* _UAPI_LINUX_IF_BRIDGE_H */

