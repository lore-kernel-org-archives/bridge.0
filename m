Return-Path: <troglobit@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:in-reply-to:references:date:message-id
 :mime-version; bh=5k6k5OzQ/nNaAhxNcy8dyG0hqPxB3EyqZUWXJxiNXVA=;
 b=VZVe0At+6TDw7PG/U/Tm9jp7AUkurQCeKoeiTwS7Ewd+b5wIFjM4lFLnE/5MRKVpYw
 oTdiVYhGwcy6799RvVVQ1vhQTQOus+nSEnUAyc6OskwB3X6sy930UNZntaKE+DkDSDgg
 tLrutCJfRHFbdfKMpIVSavG0JGdIAZ/bMDKOw7MpQ8r91/MHfsO+YwyUBxsrQH5lbXxj
 85jtwmFsPxcZxp71FoQcp9dkhpwmD2iokeasjqyfI1JmPJ4uItraV582ieHNxjIRWdBW
 /4bcfbbHyXRJlRBoEbboncuRJ5tk/O38r99LSk1XgmmTMZdFizuSgODQwR9+SlZ279Nd
 JWQw==
From: Joachim Wiberg <troglobit@gmail.com>
In-Reply-To: <20220411202315.mxgqmvktodavdmwr@skbuf>
References: <20220411133837.318876-1-troglobit@gmail.com>
 <20220411133837.318876-10-troglobit@gmail.com>
 <20220411202315.mxgqmvktodavdmwr@skbuf>
Date: Tue, 12 Apr 2022 09:57:16 +0200
Message-ID: <87czhmbuoz.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Bridge] [PATCH RFC net-next 09/13] selftests: forwarding:
	rename test groups for next bridge mdb tests
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>, Tobias Waldekranz <tobias@waldekranz.com>

On Mon, Apr 11, 2022 at 20:23, Vladimir Oltean <vladimir.oltean@nxp.com> wrote:
> On Mon, Apr 11, 2022 at 03:38:33PM +0200, Joachim Wiberg wrote:
>> -TEST_GROUP_IP4="225.1.2.3"
>> -TEST_GROUP_IP6="ff02::42"
>> -TEST_GROUP_MAC="01:00:01:c0:ff:ee"
>> +PASS_GRP_IP4="225.1.2.3"
>> +FAIL_GRP_IP4="225.1.2.4"
>> +PASS_GRP_MAC="01:00:01:c0:ff:ee"
>> +FAIL_GRP_MAC="01:00:01:c0:ff:ef"
>> +
>> +PASS_GRP_IP6="ff02::42"
>> +FAIL_GRP_IP6="ff02::43"
> This is more than just the advertised rename, the fail groups are new
> and not used in this change.

Yeah I rushed the set out to get feedback on the overall take, sorry
about this.  I'll see to fixing this for the non-RFC drop.  Thanks!
