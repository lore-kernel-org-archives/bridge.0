Message-ID: <2e59e6970901061335s1976941eo70cf01e73eaed192@mail.gmail.com>
Date: Tue, 6 Jan 2009 21:35:46 +0000
From: "richardvoigt@gmail.com" <richardvoigt@gmail.com>
In-Reply-To: <49639295.9060309@candelatech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <0598BD8415F140D9BE986E3AB9FFF35F@lzheng>
	<49639295.9060309@candelatech.com>
Subject: Re: [Bridge] vlan and bond integration in bridge
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ben Greear <greearb@candelatech.com>
Cc: Bridge Linux <bridge@lists.linux-foundation.org>

On Tue, Jan 6, 2009 at 5:19 PM, Ben Greear <greearb@candelatech.com> wrote:
> Lv Zheng wrote:
>
>> Since VLAN device in Linux cannot support VID duplication
>> across multiple lowers, that is, following commands will fail:
>>
>> vconfig set_name_type DEV_PLUS_VID_NO_PAD
>> vconfig add eth0 1
>> vconfig add eth1 1 <--- failure
>
> This should work fine..what are the errors?

And what kernel version is being discussed?  Many devices matching
"hardware VLAN aware switch engine in the appliance" are still on
2.4.x

>
> Ben
>
> --
> Ben Greear <greearb@candelatech.com>
> Candela Technologies Inc  http://www.candelatech.com
>
> _______________________________________________
> Bridge mailing list
> Bridge@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/bridge
>
