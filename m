Return-Path: <vyasevic@redhat.com>
Message-ID: <518018E6.3080601@redhat.com>
Date: Tue, 30 Apr 2013 15:17:58 -0400
From: Vlad Yasevich <vyasevic@redhat.com>
MIME-Version: 1.0
References: <1367345928-31135-1-git-send-email-vyasevic@redhat.com>
	<20130430.151212.196427351152373468.davem@davemloft.net>
In-Reply-To: <20130430.151212.196427351152373468.davem@davemloft.net>
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
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, mst@redhat.com

On 04/30/2013 03:12 PM, David Miller wrote:
> From: Vlad Yasevich <vyasevic@redhat.com>
> Date: Tue, 30 Apr 2013 14:18:45 -0400
>
>> The following series adds 2 new flags to bridge.  One flag allows
>> the user to control whether mac learning is performed on the interface
>> or not.  By default mac learning is on.
>> The other flag allows the user to control whether unicast traffic
>> is flooded (send without an fdb) to a given unicast port.  Default is
>> on.
>
> As per:
>
> 	http://marc.info/?l=linux-netdev&m=136730964130303&w=2
>
> It is absolutely, positively, not appropriate to submit new features
> at this time.
>
> If I can make my announcements more intelligable to you, please let me
> know how.
>

Sorry, missed it this morning...

-vlad
