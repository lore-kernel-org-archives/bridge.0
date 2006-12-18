Message-ID: <458666F9.8070300@cambridgebroadband.com>
Date: Mon, 18 Dec 2006 10:01:29 +0000
From: Alex Zeffertt <ajz@cambridgebroadband.com>
MIME-Version: 1.0
References: <AA48EE0D609E8547912F0039B5E47BC261BE14@SHI-EXCHBE1.shipara.hcltech.com>	<4582B8DF.2010702@cambridgebroadband.com>
	<20061215103130.237b58c6@freekitty>
In-Reply-To: <20061215103130.237b58c6@freekitty>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] bridge_list orphans in linux-2.4
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Stephen Hemminger <shemminger@osdl.org>, bridge@lists.osdl.org

Stephen Hemminger wrote:
> On Fri, 15 Dec 2006 15:01:51 +0000
> Alex Zeffertt <ajz@cambridgebroadband.com> wrote:
> 
>> Hi Majjari,
>>
>> We've solved the problem now.  It turned out that the bridge_list in the
>> kernel was not being corrupted.   The problem was actually that
>> "brctl show" was only returning the last 32 bridges created.  We upped
>> this to 2048, which required a brctl change and also a kernel module change.
>>
>> The patch is attached.
>>
>> HTH,
>>
>> Alex
> 
> Actually, I would prefer NOT to send this upstream for later 2.4 releases because
> the 2.4 code is in long term stability mode, and support >32 bridges is an enhancement,
> not a bug.

That is perfectly reasonable.  However, if the bridge-utils does not support
more than 32 bridges then it should fail to create more than 32.  At the
moment it allows you to create as many as you wish but only returns info on the
most recent 32 when you run "brctl show".

Regards,

Alex

