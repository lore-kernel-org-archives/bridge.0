Return-Path: <vyasevic@redhat.com>
Message-ID: <51406D2D.30703@redhat.com>
Date: Wed, 13 Mar 2013 08:12:29 -0400
From: Vlad Yasevich <vyasevic@redhat.com>
MIME-Version: 1.0
References: <1363139126-13396-1-git-send-email-vyasevic@redhat.com>
	<473541363155743@web2d.yandex.ru>
In-Reply-To: <473541363155743@web2d.yandex.ru>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 0/4] Allow bridge to function in
 non-promisc mode
Reply-To: vyasevic@redhat.com
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "Oleg A. Arkhangelsky" <sysoleg@yandex.ru>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>

On 03/13/2013 02:22 AM, "Oleg A. Arkhangelsky" wrote:
>
>
> 13.03.2013, 05:45, "Vlad Yasevich" <vyasevic@redhat.com>:
>
>> The series adds an ability for the bridge to function in non-promiscuous mode.
>
> What is the practical applications for such setup? In other words,
> in which cases I would want to put bridge into non-promiscuous
> mode and specify some uplink ports?
>

On of the applications would be when bridge is an edge device servicing 
a VM deployment.  Each of the VMs knows the mac address that the guest
has and may program that mac onto the uplinks.

-vlad
