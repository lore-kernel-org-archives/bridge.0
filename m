Return-Path: <jiri@resnulli.us>
Date: Thu, 5 Dec 2013 16:21:52 +0100
From: Jiri Pirko <jiri@resnulli.us>
Message-ID: <20131205152152.GB2626@minipsycho.orion>
References: <1386255025-23823-1-git-send-email-jiri@resnulli.us>
	<20131205145842.GD23147@redhat.com>
	<20131205150158.GA2626@minipsycho.orion>
	<1386256758.30495.195.camel@edumazet-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1386256758.30495.195.camel@edumazet-glaptop2.roam.corp.google.com>
Subject: Re: [Bridge] [patch net/stable] br: fix use of ->rx_handler_data in
 code executed on non-rx_handler path
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Eric Dumazet <eric.dumazet@gmail.com>
Cc: jtluka@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, stephen@networkplumber.org, edumazet@google.com, laine@redhat.com, zhiguohong@tencent.com, davem@davemloft.net

Thu, Dec 05, 2013 at 04:19:18PM CET, eric.dumazet@gmail.com wrote:
>On Thu, 2013-12-05 at 16:01 +0100, Jiri Pirko wrote:
>
>> I know. But makes more sense to have these getters here, near the
>> struct. I originally moved the definitions near br_handle_frame_finish
>> definition but I think that it is nicer to do it this way...
>
>No, this is really ugly.

Allright. Will send v2 in a jiffy.

>
>
