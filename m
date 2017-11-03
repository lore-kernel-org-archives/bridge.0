Return-Path: <allen.pais@oracle.com>
References: <1509600531-16086-1-git-send-email-allen.pais@oracle.com>
	<20171103.141428.1029481368155846689.davem@davemloft.net>
From: Allen <allen.pais@oracle.com>
Message-ID: <59FBFDFF.4050909@oracle.com>
Date: Fri, 3 Nov 2017 10:56:23 +0530
MIME-Version: 1.0
In-Reply-To: <20171103.141428.1029481368155846689.davem@davemloft.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH 1/2] net: bridge: Convert timers to use
	timer_setup()
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, keescook@chromium.org


>
>> switch to using the new timer_setup() and from_timer() api's.
>>
>> Signed-off-by: Allen Pais <allen.pais@oracle.com>
>
> These two patches do not apply cleanly to net-next, please respin.
>

  Sure.
