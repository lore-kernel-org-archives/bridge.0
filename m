Return-Path: <dsahern@gmail.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 890424031D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E4FFF40123
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1694802215; x=1695407015;
 darn=lists.linux-foundation.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qYxJ9BLaAiW6l+EYIbRNs2EfTz/cHO+AS5Sh/AKxz44=;
 b=h03w8upGyTvh9i6IluLqySFlgoxsCEun3+L7Y2cjRHeG8s8DgdXGV5FB0spIcdUtX6
 WAVhofjzKgqixcG8s8ZAUHGqKpJsW3kPsi9skI1FrXsTIlfhRzl5k6bps+07ySKMq6vW
 xxmc+aAHc5BHrCU5kyrr6OEtl8ja4R1FocyOnYfJV1RlneiOBuG2BJSIoVWPO275zLiB
 w1y8p3YF1f21yEbsyogVuoI6tRhrXJzFbRUszis81kDAMuCDgP/jyai+2SEAzwuQYzNf
 ncRPl1evmZL/OMmncYg7fz5ZH3yUHx7fLtAdZ/y+Y/8awXIwP0e3PRkBQEscJEdTaC0Z
 epLw==
Message-ID: <157bf0b3-a37b-675a-1518-7161a47aed71@gmail.com>
Date: Fri, 15 Sep 2023 12:23:32 -0600
MIME-Version: 1.0
Content-Language: en-US
References: <cover.1694625043.git.aclaudi@redhat.com>
 <844947000ac7744a3b40b10f9cf971fd15572195.1694625043.git.aclaudi@redhat.com>
 <20230915085912.78ffd25c@hermes.local>
From: David Ahern <dsahern@gmail.com>
In-Reply-To: <20230915085912.78ffd25c@hermes.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH iproute2-next 1/2] configure: add the --color
	option
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <stephen@networkplumber.org>, Andrea Claudi <aclaudi@redhat.com>
Cc: netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, Roopa Prabhu <roopa@nvidia.com>

On 9/15/23 9:59 AM, Stephen Hemminger wrote:
> On Wed, 13 Sep 2023 19:58:25 +0200
> Andrea Claudi <aclaudi@redhat.com> wrote:
> 
>> This commit allows users/packagers to choose a default for the color
>> output feature provided by some iproute2 tools.
>>
>> The configure script option is documented in the script itself and it is
>> pretty much self-explanatory. The default value is set to "never" to
>> avoid changes to the current ip, tc, and bridge behaviour.
>>
>> Signed-off-by: Andrea Claudi <aclaudi@redhat.com>
>> ---
> 
> More build time config is not the answer either.
> Don't want complaints from distribution users about the change.
> Needs to be an environment variable or config file.

I liked the intent, and it defaults to off. Allowing an on by default
brings awareness of the usefulness of the color option.

I have applied the patches, so we need either a revert or followup based
on Stephen's objections.
