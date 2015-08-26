Return-Path: <makita.toshiaki@lab.ntt.co.jp>
References: <55DCBB02.6050308@conversis.de> <20150825142158.3e95b05a@urahara>
	<55DD1DDA.2040809@conversis.de>
From: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
Message-ID: <55DD3682.1070508@lab.ntt.co.jp>
Date: Wed, 26 Aug 2015 12:46:10 +0900
MIME-Version: 1.0
In-Reply-To: <55DD1DDA.2040809@conversis.de>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] vlan "aware" bridges
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Dennis Jacobfeuerborn <dennisml@conversis.de>, Stephen Hemminger <stephen@networkplumber.org>
Cc: bridge@lists.linux-foundation.org

On 2015/08/26 11:00, Dennis Jacobfeuerborn wrote:
> On 08/25/2015 11:21 PM, Stephen Hemminger wrote:
>> On Tue, 25 Aug 2015 20:59:14 +0200
>> Dennis Jacobfeuerborn <dennisml@conversis.de> wrote:
>>
>>> Hi,
>>> through the cumulus documentation I learned that there apparently now
>>> exists a way to create a single bridge that allows vlan filtering rather
>>> than the old method using an individual bridge for each vlan.
>>> That documentation only uses this new bridge model in the context of
>>> their new ifupdown2 tool though.
>>>
>>> Is there any practical documentation out there or some
>>> tutorials/examples that explain how to use/configure such a vlan aware
>>> bridge using the basic bridge/ip toolset?
>>>
>>> Regards,
>>>   Dennis
>>
>> Did you look in current iproute2 man pages.
>>
> 
> I've looked at the man pages but they only contain information about the
> syntax of the commands and don't give any explanation of the bigger
> picture of examples of common possible setups.
> I can find plenty of examples on the net when it comes to the
> "traditional" one-bridge-per-vlan setup but none that explain similar
> setups for the vlan aware bridge.
> In fact there seem to be few people out there who even know about this
> probably because this seems to be a bit of a secret right now because of
> a lack of documentation.

Would you check this?
https://www.netdev01.org/docs/netdev_tutorial_bridge_makita_150213.pdf

Note that these slides are getting old and now the latest net-next
kernel and iproute2 have most features to manipulate vlan_filtering by
netlink rather than sysfs, like
# ip link set br0 type bridge vlan_filtering 1

Toshiaki Makita

