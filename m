Return-Path: <vyasevic@redhat.com>
Message-ID: <51AF48C6.6050206@redhat.com>
Date: Wed, 05 Jun 2013 10:18:46 -0400
From: Vlad Yasevich <vyasevic@redhat.com>
MIME-Version: 1.0
References: <1370441281-11281-1-git-send-email-vyasevic@redhat.com>
	<51AF47B3.2070902@cogentembedded.com>
In-Reply-To: <51AF47B3.2070902@cogentembedded.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCHv4 net-next 0/2] Add two new flags to bridge.
Reply-To: vyasevic@redhat.com
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: netdev@vger.kernel.org, shemminger@vyatta.com, bridge@lists.linux-foundation.org

On 06/05/2013 10:14 AM, Sergei Shtylyov wrote:
> Hello.
>
> On 05-06-2013 18:07, Vlad Yasevich wrote:
>
>> The following series adds 2 new flags to bridge.  One flag allows
>> the user to control whether mac learning is performed on the interface
>> or not.  By default mac learning is on.
>> The other flag allows the user to control whether unicast traffic
>> is flooded (send without an fdb) to a given unicast port.  Default is
>> on.
>
>> Changes since v4:
>>   - Implemented Stephen's suggestions.
>
>> Changes since v2:
>>   - removed unused "unlock" tag.
>
>> Changes since v1:
>>   - Integrated suggestion from MST to not impact RTM_NEWNEIGH and to
>>     skip lookups when learning is disabled.
>
>> Vlad Yasevich (2):
>>    bridge: Add flag to control mac learning.
>>    bridge: Add a flag to control unicast packet flood.
>
>> Vlad Yasevich (2):
>>    bridge: Add flag to control mac learning.
>>    bridge: Add a flag to control unicast packet flood.
>
>      Hm, why your patches are listed twice?
>

Copy-paste error using prior version description.  There are only 2 
patches.  Sorry about that.

-vlad

> WBR, Sergei
>

