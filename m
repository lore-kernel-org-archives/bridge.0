Return-Path: <davem@davemloft.net>
Date: Thu, 19 Dec 2013 19:28:20 -0500 (EST)
Message-Id: <20131219.192820.29526772886243119.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20131219104112.3fcdbf8a@nehalam.linuxnetplumber.net>
References: <1387430894-11220-1-git-send-email-tanxiaojun@huawei.com>
	<20131219104112.3fcdbf8a@nehalam.linuxnetplumber.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH 0/5] bridge: cleanup and fix checkpatch errors
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: stephen@networkplumber.org
Cc: bridge@lists.linux-foundation.org, bart.de.schuymer@pandora.be, tanxiaojun@huawei.com, netdev@vger.kernel.org

From: Stephen Hemminger <stephen@networkplumber.org>
Date: Thu, 19 Dec 2013 10:41:12 -0800

> On Thu, 19 Dec 2013 13:28:09 +0800
> Tan Xiaojun <tanxiaojun@huawei.com> wrote:
> 
>> Clean up and fix some checkpatch errors in bridge driver.
>> 
>> Tan Xiaojun (5):
>>   bridge: remove unnecessary condition judgment
>>   bridge: remove unnecessary parentheses
>>   bridge: add space before '(/{', after ',', etc.
>>   bridge: change "foo* bar" to "foo *bar"
>>   bridge: change the position of '{' to the pre line
 ...
> 
> Thanks, these should go to net-next.
> 
> Acked-by: Stephen Hemminger <stephen@networkplumber.org>

Series applied, thanks.
