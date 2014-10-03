Return-Path: <cwang@twopensource.com>
MIME-Version: 1.0
In-Reply-To: <542EA697.7070109@redhat.com>
References: <1412294070-11930-1-git-send-email-vyasevic@redhat.com>
	<1412294070-11930-4-git-send-email-vyasevic@redhat.com>
	<CAHA+R7OycteYron5K3YJ3qtsEE-5uUxhPkictJDWosXCihR5hA@mail.gmail.com>
	<542EA697.7070109@redhat.com>
Date: Fri, 3 Oct 2014 09:42:26 -0700
Message-ID: <CAHA+R7N9zq=CCe0bd2xa-pL0c=v7bJV7ocY7VpHSvrizG4j8Jg@mail.gmail.com>
From: Cong Wang <cwang@twopensource.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Bridge] [PATCH v3 net-next 3/3] bridge: Add filtering support
	for default_pvid
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: vyasevic@redhat.com
Cc: Stephen Hemminger <stephen@networkplumber.org>, netdev <netdev@vger.kernel.org>, Vladislav Yasevich <vyasevich@gmail.com>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>

On Fri, Oct 3, 2014 at 6:37 AM, Vlad Yasevich <vyasevic@redhat.com> wrote:
> On 10/03/2014 12:41 AM, Cong Wang wrote:
>> On Thu, Oct 2, 2014 at 4:54 PM, Vladislav Yasevich <vyasevich@gmail.com> wrote:
>>> +static int __br_vlan_set_default_pvid(struct net_bridge *br, u16 pvid)
>>> +{
>>> +       struct net_bridge_port *p;
>>> +       u16 old_pvid;
>>> +       int err;
>>> +       DECLARE_BITMAP(changed, BR_MAX_PORTS);
>>
>>
>> This bitmap will use 128 bytes on stack, why not using heap?
>>
>
> I suppose I wanted to avoid yet another memory allocation failure condition.
> Is this really going to cause issues?
>

Probably not a big issue, but generally stack is more limited than heap
in kernel.
